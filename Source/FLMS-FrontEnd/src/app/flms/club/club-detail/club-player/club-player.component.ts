import { Component, Input, OnInit } from '@angular/core';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { ClubService } from './../../club.service';
import { PopUpAddPlayerComponent } from '../pop-up-add-player/pop-up-add-player.component';
import { ClubListPlayer } from './../../../../models/club-list-player.model';
import { ClubListPlayerResponse } from './../../../../models/club-list-player-response.model';
import { Club } from 'src/app/models/match-schedule.model';
import { map, tap } from 'rxjs/operators';
import { ActivatedRoute, Router } from '@angular/router';
import { PopUpConfirmDeletePlayerComponent } from '../../pop-up-confirm-delete-player/pop-up-confirm-delete-player.component';

@Component({
  selector: 'app-club-player',
  templateUrl: './club-player.component.html',
  styleUrls: ['./club-player.component.scss']
})
export class ClubPlayerComponent implements OnInit {
  @Input() id: string;
  @Input() clubName: string;
  @Input() playerName: string;
  listPlayer: ClubListPlayer[] = [];

  defaultLogo: string = './../../../../assets/image/Default_pfp.svg.png';

  playerId: number;


  constructor(
    public dialog: MatDialog,
    private router: Router,
    private clubService: ClubService,
    private route: ActivatedRoute
  ) { 
  }

  ngOnInit(): void {
    this.initDataSource();
  }

  openDialogAddPlayer(): void {
    const dialogRef = this.dialog.open(PopUpAddPlayerComponent, {
      width: '100%',
      data: { clubId: this.id, clubName: this.clubName }
    });
    dialogRef.afterClosed().subscribe(result => {
      this.initDataSource();
      
    });
  }

  initDataSource() {
    this.clubService.getPlayerListFilter('', this.id).pipe(
      map((listPlayer: ClubListPlayerResponse) => this.listPlayer = listPlayer.players)
    ).subscribe();
  }

  getPlayerByName(player: string) {
    if (player == null) player = '';
    this.clubService.getPlayerListFilter(player, this.id).pipe(
      map((listPlayer: ClubListPlayerResponse) => this.listPlayer = listPlayer.players)
    ).subscribe();
  }

  navigateToPlayerInfo(playerId: number, clubId: number) {
    this.router.navigate(['/manager/player-detail'], { queryParams: { playerId: playerId, clubId: this.id } });
  }

  openDeleteplayerConfirm(playerId: number, clubId: number): void {
    const dialogRef = this.dialog.open(PopUpConfirmDeletePlayerComponent, {
      width: '50%',
      data: { playerId: playerId, clubId: this.id }
    });
    dialogRef.afterClosed().subscribe(result => {
      this.initDataSource();
      
    });
  }
}
