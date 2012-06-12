Feature: last.fm Live downloader
  In order to download the current track from the last.fm API
  As a music application
  I want ensure I get the right stuff

  Scenario: Download live last.fm track info
    Given a last.fm API key
    When I download the current track
    Then I get valid track info
