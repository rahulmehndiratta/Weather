# Weather


https://github.com/rahulmehndiratta/Weather/assets/10243461/c7d7ba1a-d0d8-4f53-ab50-0f41d8c2376c

A simple iOS application built with Swift that displays a 3-day weather forecast for a user-specified city using the Weather REST API.

Features
Display information about the city, including country, city name, current date, and time.
Show a 3-day weather forecast with icons representing the current weather condition, minimum and maximum temperatures in Celsius, and the date for each day.
Support for both portrait and landscape orientations.
Data persistence to avoid unnecessary requests to the REST API on subsequent launches.
Technical Details
Language: Swift
Architecture: VIPER (View, Interactor, Presenter, Entity, Router)
iOS Version: 13.0 and above
UI Design: Programmatic UI with Auto Layout
Networking: URLSession for API requests
Data Persistence: UserDefaults for storing forecast data
Unit Tests: Included for key components
How to Use
Clone the repository:

git clone https://github.com/yourusername/weather-forecast-app.git
Open the project in Xcode.

Build and run the app on your iOS device or simulator.

Enter the desired city name to get the 3-day weather forecast.

Project Structure
WeatherApp/: The main application folder.
Modules/: Contains VIPER modules (CityWeather and ForecastList).
Networking/: Handles network requests using URLSession.
Models/: Defines data models for the app.
Utilities/: Includes utility classes and extensions.
Tests/: Unit tests for important components.

Build and Run
Open the project in Xcode:

open WeatherApp.xcodeproj
Build and run the project (Cmd + R).

Unit Tests
Open the project in Xcode:

open WeatherApp.xcodeproj
Select the WeatherAppTests target.

Run the tests (Cmd + U)

