@mog @manual
Feature: Mog application current track updater
  In order to download the current track from the Mog application
  As a client of the music source
  I want to ensure I get the right stuff

  @mog_kill
  Scenario: Download Mog application current track info
    Given a song is playing in the Mog application
    And we are using the Mog application updater
    When I ask for the current track
    Then I get valid track info

  Scenario: Should not launch Mog if not already running
    Given the "Mog" application is shut down
    And we are using the Mog application updater
    When I ask for the current track
    Then the "Mog" application should not be running

  @mog_kill
  Scenario: Detect that service is available
    Given the "Mog" application is running
    And we are using the Mog application updater
    Then the Mog application should be available

  Scenario: Detect that service is not available
    Given the "Mog" application is shut down
    And we are using the Mog application updater
    Then the Mog application should not be available
