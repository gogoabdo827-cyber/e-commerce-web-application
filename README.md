# E-Commerce Web Application

Graduation project for the **Digital Egypt Pioneers Initiative (DEPI)**.

## Team B
Ali Mohamed · Ahmed Amgad · Ganna Abdelaleem · Roaa Mostafa · Hana Ahmed · Salma Ayman

## Project Overview
This project focuses on software quality assurance for the SauceDemo E-Commerce application. The project covers four testing levels:
- Manual UI Testing
- UI Automation Testing
- API Testing
- Database Testing

The goal was to verify the application's functionality, reliability, data integrity, and overall quality before release.

## Repository Contents

| File / Folder | Description |
|---------------|-------------|
| `DEPI_DATABASE_SQL.sql` | MySQL schema and 38 database test case scripts |
| `DEPI_DATABASE_REPORT.pdf` | Database testing execution report |
| `api_testcases_template.pdf` | API test cases executed using Postman |
| `TestCase_E-commerce.xlsx` | Manual UI test cases |
| `E-commerce web application_Test_Plan_Team-B.docx` | Software Test Plan |
| `Final graduation project Team-B.xlsx` | Project tracking sheet |
| `saucedemo-ui-automation/` | Selenium WebDriver automation framework built with Java, TestNG, Maven, and Page Object Model (POM) |
| `QA_Testing_Graduation_Project_Presentation.pdf` | Final project presentation covering project overview, scope, methodology, architecture, timeline, risks, and results |

## Test Summary

- **Manual UI Testing:** 19 Test Cases (17 Passed, 2 Failed)
- **UI Automation Testing:** Automated Selenium framework covering the main user workflows
- **API Testing:** 19 Test Cases (19 Passed)
- **Database Testing:** 38 Test Cases (32 Passed, 6 Expected Constraint Violations)

## Bugs Found

1. **TC_004** — Sauce Labs T-Shirt (Red) displays incorrect product information.
2. **TC_008** — Reset App State removes the cart item but does not reset the "Add to Cart" button.

## Technologies Used

- Java
- Selenium WebDriver
- TestNG
- Maven
- Page Object Model (POM)
- Postman
- MySQL Workbench
- Jira
- Microsoft Excel
- Microsoft PowerPoint

## How to Run the UI Automation Tests

### Prerequisites
- Java 17+
- Maven
- Firefox Browser

### Run

```bash
mvn clean test
```

To run with a visible browser:

```bash
mvn test -Dheadless=false
```

## How to Run the API Tests

1. Install Postman.
2. Create a Trello account and generate an API Key and Token.
3. Configure the Postman variables:
   - `base_url`
   - `APIKey`
   - `APIToken`
   - `CardID`
4. Execute the requests in `api_testcases_template.pdf`.

## How to Run the Database Tests

1. Install MySQL 8 and MySQL Workbench.
2. Open `DEPI_DATABASE_SQL.sql`.
3. Execute each section sequentially.
4. For Section 3 (TC_12–TC_17), run each statement individually, as errors are expected.

## How to Run the Manual Tests

1. Open https://www.saucedemo.com
2. Login using:
   - Username: `standard_user`
   - Password: `secret_sauce`
3. Follow the steps in `TestCase_E-commerce.xlsx`.
