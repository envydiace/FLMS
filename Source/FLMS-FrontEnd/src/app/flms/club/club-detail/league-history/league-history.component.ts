import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-league-history',
  templateUrl: './league-history.component.html',
  styleUrls: ['./league-history.component.scss']
})
export class LeagueHistoryComponent implements OnInit {
  displayedColumns: string[] = ['joinedDate','leagueName', 'won','draw', 'loss', 'goal','rank'];

  constructor() { }

  ngOnInit(): void {
  }

}
