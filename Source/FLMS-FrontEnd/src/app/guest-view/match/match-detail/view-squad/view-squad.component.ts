import { Component, Input, OnInit } from '@angular/core';
import { map } from 'rxjs/operators';
import { SquadPosition, ViewMatchSquad } from 'src/app/models/match-squad.model';
import { MatchService } from '../../match.service';

@Component({
  selector: 'app-view-squad',
  templateUrl: './view-squad.component.html',
  styleUrls: ['./view-squad.component.scss']
})
export class ViewSquadComponent implements OnInit {
  @Input() matchId: number;
  imgSrc: string = './../../../../assets/image/Default_pfp.svg.png';
  viewMatchSquad: ViewMatchSquad;

  homeStartingSquad: SquadPosition[] = [];
  homeSubstitution: SquadPosition[] = [];

  awayStartingSquad: SquadPosition[] = [];
  awaySubstitution: SquadPosition[] = [];

  position = ['ST', 'LM', 'RM', 'LB', 'RB', 'CB', 'GK'];

  constructor(
    private matchService: MatchService
  ) { }

  ngOnInit(): void {
    this.initDataSource();
  }
  initDataSource() {
    this.getSquadByMatchId(this.matchId);
  }

  getSquadByMatchId(matchId: number) {
    this.matchService.getMatchSquadByMatch(matchId).pipe(
      map((res: ViewMatchSquad) => {
        this.viewMatchSquad = res;
        this.homeStartingSquad = res.home.startingSquad;
        this.homeSubstitution = res.home.substitution;
        this.awayStartingSquad = res.away.startingSquad;
        this.awaySubstitution = res.away.substitution;
      })
    ).subscribe();
  }
}
