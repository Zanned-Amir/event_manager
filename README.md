# Event Manager

This is a simple Ruby script for managing event attendees. The script reads attendee information from a CSV file, cleans and processes the data, and generates thank-you letters for each attendee.

## Table of Contents

- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)

## Features

- Cleans and formats zip codes.
- Retrieves legislators based on zip codes using the Google Civic Information API.
- Generates thank-you letters for attendees.
- Cleans and formats phone numbers.
- Finds the most common registration day and hour.

## Prerequisites

Before running the script, make sure you have the following installed:

- Ruby
- Google Civic Information API Key

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/event-manager.git

   ```

2. Install required gems:
    ```bash
   gem install google-api-client erb
    ```
3. Configure your Google Civic Information API key:

Open the script in a text editor.
if you wnanna Replace #'YOUR_GOOGLE_API_KEY' with your actual Google Civic Information API key.

## Usage

Ensure your CSV file (event_attendees.csv) is in the project directory.

1. Run the script:
   ```bash
   ruby event_manager.rb
   ```
   View the generated thank-you letters in the 'output' directory.

## Configuration

To customize the thank-you letter template, edit the form_letter.erb file.
