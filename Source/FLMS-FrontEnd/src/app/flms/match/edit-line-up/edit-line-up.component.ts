import { CdkDragDrop, CdkDragEnd, moveItemInArray, transferArrayItem } from '@angular/cdk/drag-drop';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { first, map } from 'rxjs/operators';
import { CommonService } from 'src/app/common/common/common.service';
import { MatchDetailResponse } from 'src/app/models/match-detail-response.model';
import { MatchDetail } from 'src/app/models/match-detail.model';
import { Coordinate, MatchSquad, SquadPosition, UpdateCoordinate, UpdateSquad } from 'src/app/models/match-squad.model';
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
  temp: any;
  panelMainSquadState: boolean = true;
  panelSubstituteState: boolean = false;
  panelTeamMembersState: boolean = true;

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

  drop(event: CdkDragDrop<SquadPosition[]>) {
    if (event.previousContainer === event.container) {
      moveItemInArray(event.container.data, event.previousIndex, event.currentIndex);
      this.resetPositionKey();

      console.log(this.startingSquad);
    } else {
      if (event.container.data[event.currentIndex] != undefined) {
        // swap Coordinate
        let tempCoordinate = event.previousContainer.data[event.previousIndex].coordinate;
        event.previousContainer.data[event.previousIndex].coordinate = event.container.data[event.currentIndex].coordinate;
        event.container.data[event.currentIndex].coordinate = tempCoordinate;

        // swap Coordinate
        let tempSquadPositionId = event.previousContainer.data[event.previousIndex].squadPositionId;
        event.previousContainer.data[event.previousIndex].squadPositionId = event.container.data[event.currentIndex].squadPositionId;
        event.container.data[event.currentIndex].squadPositionId = tempSquadPositionId;

        let oldtarget = event.previousContainer.data[event.previousIndex];
        event.previousContainer.data[event.previousIndex] = event.container.data[event.currentIndex];
        event.container.data[event.currentIndex] = oldtarget;

        this.resetPositionKey();

        if (event.previousContainer.data[event.previousIndex].playerId == null) {
          event.previousContainer.data.splice(event.previousIndex, 1);
        }
      }
    }
  }

  resetPositionKey() {
    for (let index = 0; index < this.startingSquad.length; index++) {
      this.startingSquad[index].positionKey = 'P' + (index + 1);
    }
  }

  onSubmit() {
    let mains: UpdateCoordinate[] = [];
    let subs: UpdateCoordinate[] = [];

    this.startingSquad.forEach(element => {
      if (element.playerId != null) {
        let tempCoordinate: UpdateCoordinate = {
          playerId: element.playerId,
          x: element.coordinate.x,
          y: element.coordinate.y
        }

        const newUsersArray = mains;
        newUsersArray.push(tempCoordinate);
        mains = [...newUsersArray];
      }
    });

    this.substitution.forEach(element => {
      if (element.playerId != null) {
        let tempCoordinate: UpdateCoordinate = {
          playerId: element.playerId,
          x: element.coordinate.x,
          y: element.coordinate.y
        }

        const newUsersArray = subs;
        newUsersArray.push(tempCoordinate);
        subs = [...newUsersArray];
      }
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

  dragEnd($event: CdkDragEnd, squadPositionId: any) {
    const coordinate: Coordinate = $event.source.getFreeDragPosition();
    this.startingSquad.find(x => x.squadPositionId == squadPositionId).coordinate = coordinate;
  }
}
