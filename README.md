# FootBallApp

When the application lunches it's shown the splash screen.
The splash screen make request for Team list from the API.
When the data is received, the user moves to navigation controller, the root of this navigation controller is the  list of the teams screen that will appears.
when the user select one of the teams he will move to team details screen.
In the team details screen the user will see the team's logo above, the list of the players and beneath the upcoming matches of that team.
I used for upcoming matches a container view that contains page controller; linked to view controller with three labels one for the matching teams, the second is for the competition and the third is for the date of the game.


