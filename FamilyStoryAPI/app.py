from fastapi import FastAPI, Query
from icrawler.builtin import GoogleImageCrawler
import os
import time

app = FastAPI()

# Function to crawl images and measure the time taken
def download_images(keyword: str, max_num: int = 3):
    start_time = time.time()  # Record the start time

    google_crawler = GoogleImageCrawler(
        feeder_threads=1,
        parser_threads=2,
        downloader_threads=4,
        storage={'root_dir': 'images'})  # Store images in 'images' folder

    filters = dict(
        license='commercial',
    )

    # Ensure the images folder exists
    if not os.path.exists('images'):
        os.makedirs('images')

    # Start crawling
    google_crawler.crawl(keyword=keyword, filters=filters, max_num=max_num)

    end_time = time.time()  # Record the end time
    elapsed_time = end_time - start_time  # Calculate time taken
    return elapsed_time

# FastAPI route to trigger the image crawl and return the time taken

@app.get("/crawl_images/")
def crawl_images(keyword: str = Query(..., min_length=1), max_num: int = Query(3, ge=1)):
    elapsed_time = download_images(keyword, max_num)
    return {
        "status": "success",
        "message": f"Downloaded {max_num} images for keyword '{keyword}'.",
        "time_taken": f"{elapsed_time:.2f} seconds"
    }

# To run the FastAPI server, use this command in the terminal
# uvicorn script_name:app --reload