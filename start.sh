#!/bin/bash

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "Python3 is not installed. Please install Python3."
    exit 1
fi

# Check if Selenium is installed
if ! python3 -c "import selenium" &> /dev/null; then
    echo "Selenium is not installed. Installing..."
    pip3 install selenium
fi

# Define the Python script
python_script=$(cat << 'EOF'
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time

try:
    # Set Chrome options to ignore SSL certificate errors
    chrome_options = Options()
    chrome_options.add_argument("--ignore-certificate-errors")

    # Initialize the WebDriver with Chrome options
    driver = webdriver.Chrome(options=chrome_options)

    # URL of the authentication page
    url = "https://10.26.2.2:8090/httpclient.html"

    # Open the URL in the browser
    driver.get(url)

    # Wait for the page to load
    time.sleep(2)

    # Find the username and password input fields by their names and enter your credentials
    username_input = driver.find_element(By.CSS_SELECTOR, "input[name='username']")
    password_input = driver.find_element(By.CSS_SELECTOR, "input[name='password']")

    username = "sumit.chavan"
    password = "Sumit@123"

    username_input.send_keys(username)
    password_input.send_keys(password)

    # Submit the form
    login_button = driver.find_element(By.CSS_SELECTOR, "div#loginbutton")
    login_button.click()

    # Wait for the authentication process to complete
    time.sleep(5)

except Exception as e:
    print("An error occurred:", e)

finally:
    # Close the browser
    if 'driver' in locals():
        driver.quit()
EOF
)

# Execute the Python script
echo "Executing Python script..."
python3 -c "$python_script"
