@rdio @manual
Feature: Rdio application current track updater
  In order to download the current track from the Rdio application
  As a client of the music source
  I want to ensure I get the right stuff

  @rdio_kill
  Scenario: Download Rdio application current track info
    Given a song is playing in the Rdio application
    And we are using the Rdio application updater
    When I ask for the current track
    Then I get valid track info

  Scenario: Should not launch Rdio if not already running
    Given the "Rdio" application is shut down
    And we are using the Rdio application updater
    When I ask for the current track
    Then the "Rdio" application should not be running

  @rdio_kill
  Scenario: Detect that service is available
    Given the "Rdio" application is running
    And we are using the Rdio application updater
    Then the Rdio application should be available

  Scenario: Detect that service is not available
    Given the "Rdio" application is shut down
    And we are using the Rdio application updater
    Then the Rdio application should not be available
