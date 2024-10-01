from fastapi import FastAPI, Query
import asyncio
import os
import time
from icrawler.builtin import GoogleImageCrawler
import nest_asyncio

# Apply nest_asyncio to allow reentry of the event loop
nest_asyncio.apply()

app = FastAPI()

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
    filters = dict(
        license='commercial',
    )

    # Ensure the images folder exists
    if not os.path.exists('images'):
        os.makedirs('images')

    # Perform the crawling (this is still synchronous)
    crawl_start_time = time.time()
    google_crawler.crawl(keyword=keyword, filters=filters, max_num=max_num, file_idx_offset=0)
    crawl_end_time = time.time()
    print(f"Crawling completed in {crawl_end_time - crawl_start_time:.2f} seconds")

    end_time = time.time()  # End time for the entire process
    elapsed_time = end_time - start_time  # Calculate total elapsed time

    return elapsed_time

# Asynchronous function to delete all images in the folder
async def async_delete_images():
    folder_path = 'images'
    
    # Check if the directory exists
    if os.path.exists(folder_path):
        # Iterate over all files in the directory and remove them
        for filename in os.listdir(folder_path):
            file_path = os.path.join(folder_path, filename)
            
            try:
                # Remove file if it's an actual file
                if os.path.isfile(file_path):
                    os.remove(file_path)
            except Exception as e:
                print(f"Error deleting file {file_path}: {e}")
                
        return {"status": "success", "message": "All images have been deleted."}
    
    else:
        return {"status": "failure", "message": "Images directory does not exist."}

# FastAPI route to trigger the asynchronous image crawl
@app.get("/crawl_images/")
async def crawl_images(keyword: str = Query(..., min_length=1), max_num: int = Query(3, ge=1)):
    elapsed_time = await async_download_images(keyword, max_num)
    return {
        "status": "success",
        "message": f"Downloaded {max_num} images for keyword '{keyword}'.",
        "time_taken": f"{elapsed_time:.2f} seconds"
    }

# FastAPI route to delete all images
@app.delete("/delete_images/")
async def delete_images():
    result = await async_delete_images()
    return result
