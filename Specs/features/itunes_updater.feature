@itunes @manual
Feature: iTunes application current track updater
  In order to download the current track from the iTunes application
  As a client of the music source
  I want to ensure I get the right stuff

  @itunes_kill
  Scenario: Download iTunes application current track info
    Given the "iTunes" application is running
    And a song is playing
    And we are using the iTunes application updater
    When I ask for the current track
    Then I get valid track info

  Scenario: Should not launch iTunes if not already running
    Given the "iTunes" application is shut down
    And we are using the iTunes application updater
    When I ask for the current track
    Then the "iTunes" application should not be running

  @itunes_kill
  Scenario: Detect that service is available
    Given the "iTunes" application is running
    And we are using the iTunes application updater
    Then iTunes should be available

  Scenario: Detect that service is not available
    Given the "iTunes" application is shut down
    And we are using the iTunes application updater
    Then iTunes should not be available
