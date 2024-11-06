from fastapi import FastAPI, Query, Request
import os
import time
from icrawler.builtin import GoogleImageCrawler
from fastapi.staticfiles import StaticFiles
import nest_asyncio
import re
import uuid
import hashlib
import logging

nest_asyncio.apply()

app = FastAPI()

# Create a base images directory if it doesn't exist
if not os.path.exists('images'):
    os.makedirs('images')

# Mount the images directory for static file serving
app.mount("/images", StaticFiles(directory="images"), name="images")

all_urls = []  # Global list to store all URLs

def checkCrawlURL(log_record):
    """Capture image URLs from log messages and store them in all_urls."""
    print("INFO - downloader -", log_record.getMessage())
    match = re.search(r"image #\d+\t(.*)", log_record.getMessage())
    if match:
        all_urls.append(match.group(1))
        print("Current URLs:", all_urls)

async def async_download_images(keyword: str, max_num: int = 3, user_id: str = None):
    start_time = time.time()
    
    # Create a unique directory for each hashed user ID
    user_dir = os.path.join('images', user_id if user_id else str(uuid.uuid4()))
    os.makedirs(user_dir, exist_ok=True)

    google_crawler = GoogleImageCrawler(
        feeder_threads=1,
        parser_threads=2,
        downloader_threads=4,
        storage={'root_dir': user_dir}  # Store images in user-specific directory
    )

    google_crawler.downloader.logger.addFilter(checkCrawlURL)

    filters = dict(license='commercial')
    google_crawler.crawl(keyword=keyword, filters=filters, max_num=max_num, file_idx_offset=0)
    
    image_files = [os.path.join(user_dir, f) for f in os.listdir(user_dir) if f.endswith((".jpg", ".png", ".jpeg"))]

    end_time = time.time()
    elapsed_time = end_time - start_time

    return {"elapsed_time": elapsed_time, "image_files": image_files[:max_num], "image_urls": all_urls[:max_num]}

@app.get("/crawl_images/")
async def crawl_images(
    request: Request, 
    keyword: str = Query(..., min_length=1), 
    max_num: int = Query(3, ge=1)
):
    global all_urls
    all_urls.clear()

    # Generate a unique user ID based on client host and timestamp, then hash it
    raw_user_id = request.client.host + "_" + str(time.time()).replace('.', '')
    hashed_user_id = hashlib.sha256(raw_user_id.encode()).hexdigest()

    result = await async_download_images(keyword, max_num, hashed_user_id)

    base_url = str(request.base_url).rstrip("/")
    full_image_paths = [f"{base_url}/images/{hashed_user_id}/{os.path.basename(image)}" for image in result["image_files"]]

    response = {
        "status": "success",
        "message": f"Downloaded {max_num} images for keyword '{keyword}'.",
        "time_taken": f"{result['elapsed_time']:.2f} seconds",
        "image_urls": result["image_urls"],  # Original URLs
        "image_paths": full_image_paths,  # Local paths to downloaded images
        "user_id": hashed_user_id
    }

    return response

@app.delete("/delete_images/")
async def delete_images(user_id: str = Query(None)):
    folder_path = os.path.join('images', user_id) if user_id else 'images'

    if os.path.exists(folder_path):
        deleted_files = []
        for root, dirs, files in os.walk(folder_path, topdown=False):
            for file in files:
                file_path = os.path.join(root, file)
                os.remove(file_path)
                deleted_files.append(file)
            for dir in dirs:
                os.rmdir(os.path.join(root, dir))
        os.rmdir(folder_path)

        return {
            "status": "success",
            "message": f"Deleted {len(deleted_files)} images for user {user_id}.",
            "deleted_files": deleted_files
        }
    else:
        return {"status": "failure", "message": "Images directory does not exist."}

@app.get("/")
async def root():
    return {"message": "FastAPI server is working with dynamic base URL!"}
