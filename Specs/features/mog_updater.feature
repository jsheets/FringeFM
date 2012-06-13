@mog @manual
Feature: Mog application current track updater
  In order to download the current track from the Mog application
  As a client of the music source
  I want to ensure I get the right stuff

  Scenario: Download Mog application current track info
    Given a song is playing in the Mog application
    And we are using the Mog application updater
    When I ask for the current track
    Then I get valid track info
