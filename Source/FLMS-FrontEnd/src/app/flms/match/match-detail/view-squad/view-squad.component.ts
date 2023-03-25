import { Component, Input, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { MatchDetail } from 'src/app/models/match-detail.model';

@Component({
  selector: 'app-view-squad',
  templateUrl: './view-squad.component.html',
  styleUrls: ['./view-squad.component.scss']
})
export class ViewSquadComponent implements OnInit {
  @Input() matchId: number;

  constructor(
    private router: Router
  ) { }

  ngOnInit(): void {
  }

  navigateToEditLineUp() {
    this.router.navigate(['manager/edit-line-up'], { queryParams: {matchId : this.matchId}});
  }
}
