from fastapi import FastAPI, Query, Request
import os
import time
from icrawler.builtin import GoogleImageCrawler
from fastapi.staticfiles import StaticFiles
import nest_asyncio
import re
import logging

nest_asyncio.apply()

app = FastAPI()

if not os.path.exists('images'):
    os.makedirs('images')

app.mount("/images", StaticFiles(directory="images"), name="images")

all_urls = []  # Global list to store all URLs

def checkCrawlURL(log_record):
    """Capture image URLs from log messages and store them in all_urls."""
    print("INFO - downloader -", log_record.getMessage())  # Print log message
    # Extract URL from the log message
    match = re.search(r"image #\d+\t(.*)", log_record.getMessage())
    if match:
        all_urls.append(match.group(1))  # Add extracted URL to list
        print("Current URLs:", all_urls)  # Print updated URL list for debug

async def async_download_images(keyword: str, max_num: int = 3):
    start_time = time.time()

    google_crawler = GoogleImageCrawler(
        feeder_threads=1,
        parser_threads=2,
        downloader_threads=4,
        storage={'root_dir': 'images'}
    )

    # Add the custom URL extraction filter to the downloader's logger
    google_crawler.downloader.logger.addFilter(checkCrawlURL)
    
    # Adjust the filters if needed
    filters = dict(license='commercial') 

    crawl_start_time = time.time()
    google_crawler.crawl(keyword=keyword, filters=filters, max_num=max_num, file_idx_offset=0)  # with filters
    crawl_end_time = time.time()
    print(f"Crawling completed in {crawl_end_time - crawl_start_time:.2f} seconds")

    # Retrieve image file paths
    image_files = []
    for filename in os.listdir('images'):
        if filename.endswith((".jpg", ".png", ".jpeg")):
            file_path = os.path.join('images', filename)
            image_files.append(file_path)

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
    all_urls.clear()  # Clear previous URLs before each crawl

    result = await async_download_images(keyword, max_num)

    # Use the request's base URL instead of hardcoding the ngrok URL
    base_url = str(request.base_url).rstrip("/")
    full_image_paths = [f"{base_url}/images/{os.path.basename(image)}" for image in result["image_files"]]

    response = {
        "status": "success",
        "message": f"Downloaded {max_num} images for keyword '{keyword}'.",
        "time_taken": f"{result['elapsed_time']:.2f} seconds",
        "image_urls": result["image_urls"],  # List of original URLs
        "image_paths": full_image_paths  # Local paths to downloaded images
    }

    return response

@app.delete("/delete_images/")
async def delete_images():
    folder_path = 'images'

    if os.path.exists(folder_path):
        deleted_files = []
        for filename in os.listdir(folder_path):
            file_path = os.path.join(folder_path, filename)

            try:
                if os.path.isfile(file_path):
                    os.remove(file_path)
                    deleted_files.append(filename)
            except Exception as e:
                print(f"Error deleting file {file_path}: {e}")
                return {"status": "failure", "message": f"Error deleting file: {str(e)}"}

        print(f"Deleted files: {deleted_files}")
        
        return {"status": "success", "message": f"Deleted {len(deleted_files)} images.", "deleted_files": deleted_files}
    else:
        return {"status": "failure", "message": "Images directory does not exist."}

@app.get("/")
async def root():
    return {"message": "FastAPI server is working with dynamic base URL!"}
