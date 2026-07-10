# SauceDemo UI Automation

Java, Selenium, and TestNG UI tests for SauceDemo.

## Requirements

- JDK 21 or newer
- Apache Maven 3.9 or newer
- Firefox (Selenium Manager obtains the compatible driver when required)

## Run the tests

Run all tests headlessly (the default):

```powershell
mvn test
```

To see the browser while tests run:

```powershell
mvn test -Dheadless=false
```

## Notes

- Browser setup and cleanup are centralized in `base.BaseTest`.
- The tests use explicit waits; implicit waits are disabled to keep timing predictable.
- External social-media links may redirect to a provider's current domain. The tests verify the Sauce Labs destination rather than a brittle legacy hostname.
