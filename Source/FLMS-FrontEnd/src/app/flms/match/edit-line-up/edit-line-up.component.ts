import { CdkDragDrop, moveItemInArray, transferArrayItem } from '@angular/cdk/drag-drop';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { map } from 'rxjs/operators';
import { MatchDetailResponse } from 'src/app/models/match-detail-response.model';
import { MatchDetail } from 'src/app/models/match-detail.model';
import { MatchSquad, Squad, SquadPosition } from 'src/app/models/match-squad.model';
import { Player } from 'src/app/models/player.model';
import { MatchService } from '../match.service';

@Component({
  selector: 'app-edit-line-up',
  templateUrl: './edit-line-up.component.html',
  styleUrls: ['./edit-line-up.component.scss']
})
export class EditLineUpComponent implements OnInit {
  matchId: number;
  matchDetail: MatchDetail = null;
  imgSrc: string = './../../../../assets/image/Rashford.png';
  squadId: number = 20;
  matchSquad: MatchSquad;
  startingSquad: SquadPosition[] = [];
  substitution: SquadPosition[] = [];
  unsquadPlayers: Player[] = [];

  position = ['ST', 'LM', 'RM', 'LB', 'RB', 'CB', 'GK'];

  constructor(
    private MatchService: MatchService,
    private route: ActivatedRoute
  ) {
    this.route.queryParams.subscribe(params => {
      this.matchId = params['matchId'];
    });
  }

  ngOnInit(): void {
    this.initDataSource();
  }

  initDataSource() {
    this.getMatchInfoById(56);
    this.getSquadById(this.squadId);
    this.getUnsquadPlayers(this.squadId);
  }

  getMatchInfoById(matchId: number) {
    this.MatchService.getMatchInfoById(matchId).pipe(map((res: MatchDetailResponse) => this.matchDetail = res.match)).subscribe();
  }

  getSquadById(squadId: number) {
    this.MatchService.getMatchSquad(squadId).pipe(
      map((res: Squad) => {
        this.matchSquad = res.squad,
        this.startingSquad = this.matchSquad.startingSquad,
        this.substitution = this.matchSquad.substitution
      })
    ).subscribe();
  }

  getUnsquadPlayers(squadId: number) {
    this.MatchService.getUnsquadPlayers(squadId).pipe(map((res: Player[]) => this.unsquadPlayers = res)).subscribe();
  }

  drop(event: CdkDragDrop<string[]>) {
    if (event.previousContainer === event.container) {
      moveItemInArray(event.container.data, event.previousIndex, event.currentIndex);
    } else {
      // transferArrayItem(event.previousContainer.data,
      //   event.container.data,
      //   event.previousIndex,
      //   event.currentIndex);


      let oldtarget = event.previousContainer.data[event.previousIndex];
      event.previousContainer.data[event.previousIndex] = event.container.data[event.currentIndex];
      event.container.data[event.currentIndex] = oldtarget;
    }
  }

}
