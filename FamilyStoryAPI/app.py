from fastapi import FastAPI, Query, Request, HTTPException
import os
from fastapi.responses import FileResponse, JSONResponse
import time
from icrawler.builtin import GoogleImageCrawler
from fastapi.staticfiles import StaticFiles
import nest_asyncio
import re
import uuid
import hashlib
import asyncio
import requests
import time
import io
from PIL import Image
import base64
from googletrans import Translator
import typing_extensions as typing
import os
import google.generativeai as genai
from google.ai.generativelanguage_v1beta.types import content
import json

class paraphrased(typing.TypedDict):
    original_text: str
    paraphrased_texts: list[str]
    
class textClassification(typing.TypedDict):
    original_text: str
    classification: str
    
genai.configure(api_key="AIzaSyC16AN-fYC6HVb5VXj8YWwm4PJKzAkfD_A")

classfication_config = {
        "temperature": 1,
        "top_p": 0.95,
        "top_k": 40,
        "max_output_tokens": 8192,
        "response_schema": textClassification,
        "response_mime_type": "application/json"
    }

classfication = genai.GenerativeModel(
    model_name="gemini-1.5-flash",
    generation_config=classfication_config,
)

paraphrasing_config = {
        "temperature": 1,
        "top_p": 0.95,
        "top_k": 40,
        "max_output_tokens": 8192,
        "response_schema": paraphrased,
        "response_mime_type": "application/json"
    }

paraphrasing = genai.GenerativeModel(
    model_name="gemini-1.5-flash",
    generation_config=paraphrasing_config,
)
    
    
model_id = "stabilityai/stable-diffusion-3.5-large-turbo"
API_URL = f"https://api-inference.huggingface.co/models/{model_id}"
headers = {"Authorization": "Bearer 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"}



nest_asyncio.apply()

app = FastAPI()

if not os.path.exists('images'):
    os.makedirs('images')

app.mount("/images", StaticFiles(directory="images"), name="images")

all_urls = []

def query(payload):
    start_time = time.time()
    response = requests.post(API_URL, headers=headers, json=payload)
    end_time = time.time()
    elapsed_time = end_time - start_time

    print(f"Elapsed time: {elapsed_time:.2f} seconds")
    return response.content

async def generateImage(keyword: str,user_id):
    user_dir = os.path.join('images', user_id if user_id else str(uuid.uuid4()))
    os.makedirs(user_dir, exist_ok=True)
    translator = Translator()

    # Text to translate (Indonesian to English)

    # Translate text
    translated = translator.translate(keyword, src='id', dest='en')
    
    keyword = translated.text
    
    prompt = f"""
Generate a simple, clean image inspired by {keyword}, focusing on childhood. Use soft colors, minimal details, and playful shapes to convey innocence and joy in a straightforward, uncluttered style.
"""
    output = query({
        "inputs": prompt
    })
    if isinstance(output, bytes):
        image = Image.open(io.BytesIO(output))
        if image.mode != "RGB":
            image = image.convert("RGB")
        file_path = os.path.join("images",user_id, "000001.jpg")
        image.save(file_path, format="JPEG")
        print(f"Image saved at: {file_path}")
    elif isinstance(output, str):
        try:
            image_data = base64.b64decode(output)
            image = Image.open(io.BytesIO(image_data))
            if image.mode != "RGB":
                image = image.convert("RGB")
            file_path = os.path.join("images",user_id, "000001.jpg")
            image.save(file_path, format="JPEG")
            print(f"Image saved at: {file_path}")
        except:
            print("Failed to decode the string as a base64 encoded image.")
    else:
        print("Output is not in a recognizable format (bytes or base64 encoded string).")

def checkCrawlURL(log_record):
    """Capture image URLs from log messages and store them in all_urls."""
    print("INFO - downloader -", log_record.getMessage())
    match = re.search(r"image #\d+\t(.*)", log_record.getMessage())
    if match:
        all_urls.append(match.group(1))
        print("Current URLs:", all_urls)

async def async_download_images(keyword: str, max_num: int = 3, user_id: str = None):
    start_time = time.time()
    
    user_dir = os.path.join('images', user_id if user_id else str(uuid.uuid4()))
    os.makedirs(user_dir, exist_ok=True)

    google_crawler = GoogleImageCrawler(
        feeder_threads=1,
        parser_threads=2,
        downloader_threads=4,
        storage={'root_dir': user_dir} 
    )

    google_crawler.downloader.logger.addFilter(checkCrawlURL)

    filters = dict(license='commercial,modify')
    
    await asyncio.to_thread(google_crawler.crawl, keyword=keyword, filters=filters, max_num=max_num, file_idx_offset=2)
    
    image_files = [os.path.join(user_dir, f) for f in os.listdir(user_dir) if f.endswith((".jpg", ".png", ".jpeg"))]

    end_time = time.time()
    elapsed_time = end_time - start_time

    return {"elapsed_time": elapsed_time, "image_files": image_files[:max_num], "image_urls": all_urls[:max_num]}

@app.get("/crawl_images/{user_id}")
async def crawl_images(
    request: Request, 
    user_id: str,
    keyword: str = Query(..., min_length=1), 
    max_num: int = Query(3, ge=1)
):
    global all_urls
    all_urls.clear()
    
    tasks = [
    asyncio.create_task(generateImage(keyword=keyword, user_id=user_id)),
    asyncio.create_task(async_download_images(keyword, max_num, user_id))   
]
    results = await asyncio.gather(*tasks)
    folder_path = os.path.join("images", user_id)
    
    # Check if the user's folder exists
    if not os.path.exists(folder_path):
        return JSONResponse(
            status_code=404, 
            content={"status": "failure", "message": f"No images found for user {user_id}."}
        )
    
    # List all image files in the folder
    image_files = []
    for file_name in os.listdir(folder_path):
        file_path = os.path.join(folder_path, file_name)
        
        # Only include files with image extensions
        if os.path.isfile(file_path) and file_name.lower().endswith((".jpg", ".png", ".jpeg")):
            image_files.append(f"{request.base_url}fetch_image/{user_id}/{file_name}")
    
    # Check if no images were found in the folder
    if not image_files:
        return JSONResponse(
            status_code=404, 
            content={"status": "failure", "message": f"No images found for user {user_id}."}
        )
    
    # Return the list of images and their details
    return {
        "status": "success",
        "user_id": user_id,
        "images_urls": image_files
    }


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
    

@app.get("/fetch_image/{user_id}/{filename}")
async def fetch_image(user_id: str, filename: str):
    """
    Serve a specific image file for a user.
    """
    file_path = os.path.join("images", user_id, filename)
    
    # Check if the file exists
    if not os.path.exists(file_path):
        raise HTTPException(status_code=404, detail="Image not found")
    
    # Determine the media type based on the file extension
    media_type = "image/jpeg" if filename.lower().endswith(".jpg") or filename.lower().endswith(".jpeg") else "image/png"
    
    # Return the file as a streaming response
    return FileResponse(file_path, media_type=media_type, filename=filename)

@app.get("/")
async def root():
    return {"message": "FastAPI server is working with dynamic base URL!"}

@app.get("/generate_paraphrasing/{user_id}")
async def generate_paraphrasing(
    text: str = Query(..., min_length=1, description="Text to be simplified.")
):
    try:
        # Define the prompt using the user-provided text
        prompt = (
            f"Ubahlah kalimat berikut '{text}' menjadi tiga kalimat sederhana yang mudah dipahami oleh anak kecil "
            "dengan autism spectrum disorder. Gunakan gaya bahasa deskriptif yang menggambarkan tindakan atau situasi, "
            "tanpa memberikan instruksi langsung. Pastikan jumlah kata dalam hasil akhir hampir sama dengan jumlah "
            "kata pada kalimat asli."
        )
        
        # Generate response
        response = paraphrasing.generate_content(prompt)

        # Ensure response content is available
        if not response or not response.text:
            raise HTTPException(status_code=500, detail="Failed to generate content.")
        try:
            response_json = json.loads(response.text)
        except json.JSONDecodeError as e:
            raise HTTPException(status_code=500, detail=f"Failed to parse JSON: {str(e)}")
        
        return response_json
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")

@app.get("/classify_text/{user_id}")
async def generate_paraphrasing(
    text: str = Query(..., min_length=1, description="Text to be classify.")
):
    try:
        # Define the prompt using the user-provided text
        prompt = """
        Anda bertugas mengidentifikasi apakah teks berikut adalah "Instructive" atau "Descriptive." Jika teks tidak dapat diidentifikasi sebagai salah satu dari keduanya, kembalikan hasil sebagai "Undefined."
        
        Contoh deskriptif: aku menggosok gigi.  
        Contoh instruktif: ayo gosok gigi.  
        Contoh Tidak Terdefinisi: Mengandung bahasa kasar atau tidak jelas.
        Kembalikan hasil hanya dalam format: "Instructive," "Descriptive," atau "Undefined."
        text: {text}
        """.format(text=text)
            
        
        # Generate response
        response = classfication.generate_content(prompt)

        # Ensure response content is available
        if not response or not response.text:
            raise HTTPException(status_code=500, detail="Failed to generate content.")
        try:
            response_json = json.loads(response.text)
        except json.JSONDecodeError as e:
            raise HTTPException(status_code=500, detail=f"Failed to parse JSON: {str(e)}")
        
        return response_json
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")
