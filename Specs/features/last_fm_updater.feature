@lastfm @manual
Feature: last.fm Live downloader
  In order to download the current track from the last.fm API
  As a client of the music source
  I want to ensure I get the right stuff

  Scenario: Download live last.fm current track info
    Given we have a last.fm API key
    And we are using the last.fm updater
    When I ask for the current track
    Then I get valid track info
