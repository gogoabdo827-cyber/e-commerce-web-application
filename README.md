# e-commerce-web-application
Graduation project for Digital Egypt Pioneers Initiative
# E-Commerce Web Application — QA Testing Project
Graduation project for the Digital Egypt Pioneers Initiative (DEPI) — May 2025

## Team B
Ali Mohamed · Ahmed Amgad · Ganna Abdelaleem · Roaa Mostafa · Hana Ahmed · Salma Ayman

## Project Overview
This is a software quality assurance project. We tested two applications:
- **SauceDemo** (saucedemo.com) — a demo e-commerce website
- **Trello REST API** (api.trello.com) — card management API

## What's Inside This Repo
| File | Description |
|------|-------------|
| `DEPI_DATABASE_SQL.sql` | MySQL schema + 38 database test case scripts |
| `DEPI_DATABASE_REPORT.pdf` | Database testing results report |
| `api_testcases_template.pdf` | 19 API test cases executed in Postman |
| `TestCase_E-commerce.xlsx` | 19 manual UI test cases for SauceDemo |
| `E-commerce web application_Test_Plan_Team-B.docx` | Full test plan document |
| `Final graduation project Team-B.xlsx` | Master project tracking sheet |

## Test Summary
- **Manual UI Tests:** 19 test cases — 17 Pass, 2 Fail
- **API Tests (Postman):** 19 test cases — 19 Pass
- **Database Tests (MySQL):** 38 test cases — 32 Pass, 6 Expected Errors (constraint violations)

## Bugs Found
1. **TC_004** — Sauce Labs T-Shirt (Red) displays incorrect product information
2. **TC_008** — Reset App State removes item from cart but does not reset the "Add to Cart" button

## Tools Used
- Postman (API testing)
- MySQL Workbench (database testing)
- Jira (bug tracking)
- Microsoft Excel (test case management)

## How to Run the Database Tests
1. Install MySQL 8 and MySQL Workbench
2. Open `DEPI_DATABASE_SQL.sql`
3. Run each section one by one
4. For Section 3 (TC_12–TC_17), run each statement separately — errors are expected

## How to Run the API Tests
1. Install Postman
2. Create a Trello account and generate an API Key + Token at trello.com/power-ups/admin
3. Set Postman variables: `base_url`, `APIKey`, `APIToken`, `CardID`
4. Follow the steps in `api_testcases_template.pdf`

## How to Run the Manual UI Tests
1. Open any browser and go to saucedemo.com
2. Use username: `standard_user` / password: `secret_sauce`
3. Follow the steps in `TestCase_E-commerce.xlsx`
