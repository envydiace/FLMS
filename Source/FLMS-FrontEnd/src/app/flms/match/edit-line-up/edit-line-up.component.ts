import { CdkDragDrop, moveItemInArray, transferArrayItem } from '@angular/cdk/drag-drop';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { first, map } from 'rxjs/operators';
import { CommonService } from 'src/app/common/common/common.service';
import { MatchDetailResponse } from 'src/app/models/match-detail-response.model';
import { MatchDetail } from 'src/app/models/match-detail.model';
import { MatchSquad, SquadPosition, UpdateSquad } from 'src/app/models/match-squad.model';
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
  unsquadPlayers: SquadPosition[] = [];
  updateSquadModel: UpdateSquad;
  position = ['ST', 'LM', 'RM', 'LB', 'RB', 'CB', 'GK'];
  defaultLogo: string = './../../../../assets/image/clubDefaultLogo.png';
  defaultAvatar: string = './../../../../assets/image/default-avatar-profile-icon.webp';

  constructor(
    private MatchService: MatchService,
    private commonService: CommonService,
    private route: ActivatedRoute
  ) {
    this.route.queryParams.subscribe(params => {
      this.squadId = params['squadId'];
    })
  }

  ngOnInit(): void {
    this.initDataSource();
  }

  initDataSource() {
    this.getSquadById(this.squadId);
  }

  getSquadById(squadId: number) {
    this.MatchService.getMatchSquad(squadId).pipe(
      map((res: MatchSquad) => {
        this.matchSquad = res,
          this.startingSquad = res.squadPositions.filter(p => p.positionKey != 'P0'),
          this.substitution = res.squadPositions.filter(p => p.positionKey == 'P0'),
          this.unsquadPlayers = res.unSquadPositions
      })
    ).subscribe();
  }

  drop(event: CdkDragDrop<string[]>) {
    if (event.previousContainer === event.container) {
      moveItemInArray(event.container.data, event.previousIndex, event.currentIndex);
      console.log(this.startingSquad);
      console.log(this.substitution);
      console.log(this.unsquadPlayers);

      this.resetPositionKey();
    } else {
      if (event.previousContainer.data[event.currentIndex] != undefined) {
        let oldtarget = event.previousContainer.data[event.previousIndex];
        event.previousContainer.data[event.previousIndex] = event.container.data[event.currentIndex];
        event.container.data[event.currentIndex] = oldtarget;
      } else {
        if (this.startingSquad.length < 7) {
          transferArrayItem(event.previousContainer.data,
            event.container.data,
            event.previousIndex,
            event.currentIndex);
        }
      }


      console.log(this.startingSquad);
      console.log(this.substitution);
      console.log(this.unsquadPlayers);

    }
  }

  resetPositionKey() {
    for (let index = 0; index < this.startingSquad.length; index++) {
      this.startingSquad[index].positionKey = 'P' + (index + 1);
    }
  }

  onSubmit() {
    let mains: number[] = [];
    let subs: number[] = [];

    this.startingSquad.forEach(element => {
      const newUsersArray = mains;
      newUsersArray.push(element.playerId);
      mains = [...newUsersArray];
    });

    this.substitution.forEach(element => {
      const newUsersArray = subs;
      newUsersArray.push(element.playerId);
      subs = [...newUsersArray];
    });

    const updateSquadModel = new UpdateSquad(this.squadId, mains, subs);

    this.MatchService.updateSquad(updateSquadModel)
      .pipe(first())
      .subscribe({
        next: repsonse => {
          this.commonService.sendMessage(repsonse.message, 'success')
        },
        error: error => {
          this.commonService.sendMessage(error.error.message, 'fail')
        }
      });
  }
}
