# FetchRecipeApp
Summary
The Fetch Recipe App is a SwiftUI-based application that fetches and displays recipes from a public API. It provides a clean and interactive user interface with the following features:

Displays a list of recipes, including the name, cuisine type, and image.
Allows users to tap on a recipe to view its details, including:
Full-sized image.
Cuisine type.
Links to the original source and a YouTube video (if available).
Includes a refresh button to reload the list of recipes.
Handles malformed or empty data gracefully by showing appropriate error messages.

### Screenshots

1. **Recipe Detail View**:
   ![Recipe Details View](https://github.com/gantab665/FetchRecipeApp/blob/main/Screenshot2.png)

2. **Recipe List View**:
    ![Recipe List View](https://raw.githubusercontent.com/gantab665/FetchRecipeApp/main/screenshot1.png)

Focus Areas:
Concurrency with async/await: Ensured all asynchronous operations, including API calls and image loading, use modern concurrency features.
Error Handling: Handled errors like malformed data, empty data, and network issues gracefully.
Displayed meaningful error messages for better user experience.
Efficient Network Usage:
Implemented lazy loading and caching of images to reduce bandwidth consumption.
Clean UI Design:
Designed the app using SwiftUI, focusing on responsiveness and a user-friendly layout.

Time Spent
Total Time: Approximately 4 hours
Project Setup: 30 minutes
API Integration and Model Creation: 1 hour
SwiftUI Interface Design: 1 hour
Error Handling and Edge Case Testing: 30 minutes
Enhancements (Detail View and Links): 1 hour

Trade-offs and Decisions
No Third-Party Libraries:
To comply with the requirements, avoided libraries like Alamofire or Kingfisher.
Instead, implemented custom caching and relied on native Apple frameworks.
Error Prioritization:
Focused on handling malformed and empty datasets instead of optimizing animations or advanced UI features.
Weakest Part of the Project
Image Caching:
While basic caching was implemented, it could be further optimized for production environments.
Testing:
Unit tests cover core functionality, but UI and integration tests were not included due to time constraints.
Additional Information
Edge Case Handling:
Malformed Data: Displays a descriptive error message and does not attempt to load partial or invalid data.
Empty Data: Shows "No recipes available" when the dataset is empty.
Future Enhancements:
Add animations for better user interaction.
Implement sorting and filtering options for the recipe list.

