@spotify @manual
Feature: Spotify application current track updater
  In order to download the current track from the Spotify application
  As a client of the music source
  I want to ensure I get the right stuff

  @spotify_kill
  Scenario: Download Spotify application current track info
    Given a song is playing in the Spotify application
    And we are using the Spotify application updater
    When I ask for the current track
    Then I get valid track info

  Scenario: Should not launch Spotify if not already running
    Given the "Spotify" application is shut down
    And we are using the Spotify application updater
    When I ask for the current track
    Then the "Spotify" application should not be running

  @spotify_kill
  Scenario: Detect that service is available
    Given the "Spotify" application is running
    And we are using the Spotify application updater
    Then the Spotify application should be available

  Scenario: Detect that service is not available
    Given the "Spotify" application is shut down
    And we are using the Spotify application updater
    Then the Spotify application should not be available
