# Employee Directory App

Welcome to the Employee Directory App, an intuitive and user-friendly platform for managing and viewing employee details within a company. Built with Ruby on Rails and leveraging the Reqres API for data, this application showcases a clean and functional interface for accessing employee information.

## Features

- List view of employees fetched from the Reqres API.
- Detailed view pages for individual employee information.
- Pagination controls for easy navigation through employee records.

## Installation

To get started with the Employee Directory App on your local machine, follow these steps:

### Prerequisites

Ensure you have the following installed:
- Ruby (version as specified in `.ruby-version`)
- Rails (version 7 or above)
- Bundler

### Clone the repository

```bash
git clone https://github.com/your-github/employee-directory.git
cd employee-directory
```

### Install dependencies

```bash
bundle install
```

### Start the server

```bash
rails server
```

### Usage

The application will be available at http://localhost:3000. Open this URL in your web browser to access the Employee Directory App.

## Available Routes

- `GET /`: The root path displays a list of employees.
- `GET /employees`: Alias for the root path, displaying the list of employees.
- `GET /employees/:id`: Displays detailed information for a specific employee.

### Testing

To run the test suite, execute the following command:

```bash
bundle exec rspec
```

## Contributions

Contributions are welcome! Please feel free to submit a pull request or open an issue if you encounter any problems.

## License

This project is open source and available under the [MIT License](LICENSE).