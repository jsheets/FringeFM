@spotify @manual
Feature: Spotify application current track updater
  In order to download the current track from the Spotify application
  As a client of the music source
  I want to ensure I get the right stuff

  Scenario: Download Spotify application current track info
    Given a song is playing in the Spotify application
    And we are using the Spotify application updater
    When I ask for the current track
    Then I get valid track info
