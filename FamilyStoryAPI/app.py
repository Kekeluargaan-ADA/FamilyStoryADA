from fastapi import FastAPI, Query
import os
import time
from icrawler.builtin import GoogleImageCrawler
from fastapi.staticfiles import StaticFiles
import nest_asyncio

# Apply nest_asyncio to allow reentry of the event loop
nest_asyncio.apply()

app = FastAPI()

# Ensure the images directory exists
if not os.path.exists('images'):
    os.makedirs('images')

# Mount the images directory to serve static files (images)
app.mount("/images", StaticFiles(directory="images"), name="images")

# Asynchronous image crawler function
async def async_download_images(keyword: str, max_num: int = 3):
    start_time = time.time()  # Start time for the entire process

    # Initialize the GoogleImageCrawler
    google_crawler = GoogleImageCrawler(
        feeder_threads=1,
        parser_threads=2,
        downloader_threads=4,
        storage={'root_dir': 'images'}
    )

    # Set filters for the crawler
    filters = dict(license='commercial')

    # Perform the crawling (this is still synchronous)
    crawl_start_time = time.time()
    google_crawler.crawl(keyword=keyword, filters=filters, max_num=max_num, file_idx_offset=0)
    crawl_end_time = time.time()
    print(f"Crawling completed in {crawl_end_time - crawl_start_time:.2f} seconds")

    # Get the downloaded image file paths
    image_files = []
    for filename in os.listdir('images'):
        if filename.endswith((".jpg", ".png", ".jpeg", ".gif")):  # Collect only image files
            file_path = os.path.join('images', filename)
            image_files.append(file_path)  # Store file path

    end_time = time.time()  # End time for the entire process
    elapsed_time = end_time - start_time  # Calculate total elapsed time

    return {"elapsed_time": elapsed_time, "image_files": image_files[:max_num]}

# FastAPI route to trigger the asynchronous image crawl
@app.get("/crawl_images/")
async def crawl_images(keyword: str = Query(..., min_length=1), max_num: int = Query(3, ge=1)):
    result = await async_download_images(keyword, max_num)

    # Update with your ngrok URL
    ngrok_url = "https://working-epic-dodo.ngrok-free.app"
    full_image_urls = [f"{ngrok_url}/images/{os.path.basename(image)}" for image in result["image_files"]]

    response = {
        "status": "success",
        "message": f"Downloaded {max_num} images for keyword '{keyword}'.",
        "time_taken": f"{result['elapsed_time']:.2f} seconds",
        "image_urls": full_image_urls  # Return the list of full image URLs
    }

    return response

@app.delete("/delete_images/")
async def delete_images():
    folder_path = 'images'

    # Check if the directory exists
    if os.path.exists(folder_path):
        deleted_files = []  # To store successfully deleted files
        for filename in os.listdir(folder_path):
            file_path = os.path.join(folder_path, filename)

            try:
                if os.path.isfile(file_path):
                    os.remove(file_path)
                    deleted_files.append(filename)  # Add to deleted files list
            except Exception as e:
                print(f"Error deleting file {file_path}: {e}")
                return {"status": "failure", "message": f"Error deleting file: {str(e)}"}

        # Debugging: Print which files were deleted
        print(f"Deleted files: {deleted_files}")
        
        return {"status": "success", "message": f"Deleted {len(deleted_files)} images.", "deleted_files": deleted_files}
    else:
        return {"status": "failure", "message": "Images directory does not exist."}


@app.get("/")
async def root():
    return {"message": "FastAPI server is working with ngrok!"}