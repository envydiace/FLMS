import { Component, Input, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { LeagueService } from '../../league.service';
import { map, tap } from 'rxjs/operators';
import { LeagueStatisticResponse } from './../../../../models/league-statistics-response-model';
import { LeagueStanding, TopAssist, TopScorer } from 'src/app/models/league-statistics-model';
import { NgttRound, NgttTournament } from 'ng-tournament-tree';
import { LeagueStatisticTypeKO } from 'src/app/models/league-statistic-type-ko.model';
import { CoupleNode, LeagueTree, TreeNode } from 'src/app/models/league-tree.model';

@Component({
  selector: 'app-league-statistic',
  templateUrl: './league-statistic.component.html',
  styleUrls: ['./league-statistic.component.scss']
})
export class LeagueStatisticComponent implements OnInit {
  displayLeagueStandingColumns: string[] = ['No', 'Team', 'Matches', 'W-D-L', '+/-', 'Points', 'History'];
  displayTopPlayer: string[] = ['No', 'Player', 'Record'];
  @Input() leagueId: number;
  @Input() leagueType: string;
  leagueStanding: LeagueStanding[];
  topScorer: TopScorer[];
  topAssist: TopAssist[];

  leagueTree: CoupleNode[] = [];
  treeHeight: number;
  public singleEliminationTournament: NgttTournament;
  winner: TreeNode;

  constructor(
    private route: ActivatedRoute,
    private LeagueService: LeagueService,
    private router: Router,
  ) { }

  ngOnInit(): void {
    this.initDataSource();
  }


  initDataSource() {
    if (this.leagueType == 'LEAGUE') this.getLeagueStatistic();
    if (this.leagueType == 'KO') this.getLeagueStatisticTypeKO();

  }

  getLeagueStatistic() {
    this.LeagueService.getLeagueStatistics(this.leagueId).pipe(
      map((res: LeagueStatisticResponse) => {
        this.leagueStanding = res.leagueStanding,
          this.topScorer = res.topScore,
          this.topAssist = res.topAssist
      })).subscribe();
  }

  getLeagueStatisticTypeKO() {
    this.LeagueService.getLeagueStatisticTypeKO(this.leagueId).pipe(
      map((res: LeagueStatisticTypeKO) => {
        this.leagueTree = res.listNode;
        this.treeHeight = res.height;
        this.topScorer = res.topScore;
        this.topAssist = res.topAssist;
        if (res != null && res != undefined) this.bindNodeIntoTree(res.listNode)
      })).subscribe();
  }

  bindNodeIntoTree(res: CoupleNode[]) {
    const listNode = res;
    const rounds: NgttRound[] = [];
    for (let index = this.treeHeight; index >= 1; index--) {
      let matches = listNode.filter(n => n.deep == index);

      let round: NgttRound;
      if (index == 2) {
        round = {
          type: 'Final',
          matches
        };
      } else if (index == 1) {
        this.winner = matches[0].participation[0];
      } else {
        round = {
          type: 'Winnerbracket',
          matches
        };
      }

      const parentRound = listNode.filter(n => n.deep == index - 1);
      if (matches.length < parentRound.length * 2) {
        const emptyMatch: CoupleNode = {
          deep: index,
          parentId: null,
          participation: null
        }
        for (let i = matches.length + 1; i <= parentRound.length * 2; i++) {

          round.matches.push(emptyMatch);
        }
      }


      if (round != undefined && round != null) rounds.push(round);
    }
    this.singleEliminationTournament = {
      rounds
    };
  }
}
