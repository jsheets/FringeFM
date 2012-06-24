@lastfm @manual
Feature: last.fm Web API current track updater
  In order to download the current track from the last.fm API
  As a client of the music source
  I want to ensure I get the right stuff

  @lastfm_web
  Scenario: Download live last.fm current track info
    Given we have a last.fm API key
    And we are using the last.fm web updater
    When I ask for the current track
    Then I get valid track info

  @lastfm_app @lastfm_kill
  Scenario: Download last.fm application current track info
    Given a song is playing in the last.fm application
    And we are using the last.fm application updater
    When I ask for the current track
    Then I get valid track info

  @lastfm_app
  Scenario: Should not launch Last.fm if not already running
    Given the "Last.fm" application is shut down
    And we are using the last.fm application updater
    When I ask for the current track
    Then the "Last.fm" application should not be running

  @lastfm_app @lastfm_kill
  Scenario: Detect that service is available
    Given the "Last.fm" application is running
    And we are using the last.fm application updater
    Then the Last.fm application should be available

  @lastfm_app
  Scenario: Detect that service is not available
    Given the "Last.fm" application is shut down
    And we are using the last.fm application updater
    Then the Last.fm application should not be available
