# Dinners of Week

## Project Overview
Dinners of Week application is designed to help companies keep track of daily and weekly meals. 
Users can create or join teams within the company and view or edit the weekly meal schedule. 
This app provides an organized way to manage meal planning and ensure everyone in the team is informed about the upcoming meals.

## Features
- User Management: Users can create accounts, join existing teams, or create new teams.
- Meal Tracking: View and edit the weekly meal schedule.
- Team Collaboration: Work collaboratively within teams to manage meal plans.
- Data Persistence: User preferences and session information are stored to keep users logged in and maintain their settings.

## Database Design
Used Supabase for our database management because of its robust features, real-time capabilities, and seamless integration with other tools.

The database schema includes the following tables and relationships:

### Tables
- user: Stores user information.
- teams: Contains details about the different teams.
- foods: Lists all the available meals.
- weekly_Food: Manages the meals assigned to each team for each day of the week.
### View
weekly_food_detail: A view created to show detailed information about the meals and the teams, combining data from the foods and teams tables.
The foods and teams tables have a many-to-many relationship, which is effectively managed using this view to simplify queries and data management.

### Database Diagram
![Database Diagram](https://github.com/Ceren-Canbaz/Dinners-of-Week/blob/main/assets/screenshots/diagram.png)


## Data Storage
Used SharedPreferences to keep the user logged in and maintain their settings. This ensures a smooth user experience by persisting data locally on the device.

## State Management
For state management, we utilize BLoC (Business Logic Component) and Cubit, which provide a reactive and predictable way to manage the state of the application. These libraries help in building scalable and maintainable applications by separating business logic from UI components.
## Application Screenshots

<p align="center">
  <img src="https://github.com/Ceren-Canbaz/Dinners-of-Week/blob/main/assets/screenshots/splash.png" alt="Login Screen" width="200"/>
  <img src="https://github.com/Ceren-Canbaz/Dinners-of-Week/blob/main/assets/screenshots/signup.png" alt="Login Screen" width="200"/>
  <img src="https://github.com/Ceren-Canbaz/Dinners-of-Week/blob/main/assets/screenshots/signin.png" alt="Login Screen" width="200"/>
  <img src="https://github.com/Ceren-Canbaz/Dinners-of-Week/blob/main/assets/screenshots/team_main.png" alt="Login Screen" width="200"/>
  <img src="https://github.com/Ceren-Canbaz/Dinners-of-Week/blob/main/assets/screenshots/team_page_init.png" alt="Login Screen" width="200"/>
  <img src="https://github.com/Ceren-Canbaz/Dinners-of-Week/blob/main/assets/screenshots/weekly_plan.png" alt="Login Screen" width="200"/>
  <img src="https://github.com/Ceren-Canbaz/Dinners-of-Week/blob/main/assets/screenshots/foods.png" alt="Login Screen" width="200"/>
</p>

## Project Structure

Since this project is an MVP (Minimum Viable Product), all operations are handled in the repository layer without using separate data sources. The project structure is organized to facilitate scalability and maintainability. Here is an overview of the structure:

### Data Structure
- **Data Layer**
  - Handles data operations such as fetching, storing, and updating team data.
  - Repository interfaces and implementations reside here.
  - Example:
    ```plaintext
    lib/features/team/data/
    ├── models/
    ├── repositories/
    └── data_sources/ (if needed in future)
    ```

- **Domain Layer**
  - Contains business logic and domain models.
  - Use cases that encapsulate specific actions or operations.
  - Example:
    ```plaintext
    lib/features/team/domain/
    ├── entities/
    ├── usecases/
    └── repositories/
    ```

- **Presentation Layer**
  - Manages the UI and user interactions.
  - Includes BLoC/Cubit for state management.
  - Example:
    ```plaintext
    lib/features/team/presentation/
    ├── bloc/
    ├── pages/
    └── widgets/
    ```
