@rdio @manual
Feature: Rdio application current track updater
  In order to download the current track from the Rdio application
  As a client of the music source
  I want to ensure I get the right stuff

  Scenario: Download Rdio application current track info
    Given a song is playing in the Rdio application
    And we are using the Rdio application updater
    When I ask for the current track
    Then I get valid track info
