import { Component, Input, OnInit } from '@angular/core';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { PopUpAddPlayerComponent } from '../pop-up-add-player/pop-up-add-player.component';

@Component({
  selector: 'app-club-player',
  templateUrl: './club-player.component.html',
  styleUrls: ['./club-player.component.scss']
})
export class ClubPlayerComponent implements OnInit {
  @Input() id: string;
  @Input() clubName: string;

  constructor(
    public dialog: MatDialog
  ) { }

  ngOnInit(): void {
  }

  openDialogAddPlayer(): void {
    const dialogRef = this.dialog.open(PopUpAddPlayerComponent, {
      width: '100%',
      data: { clubId: this.id, clubName: this.clubName }
    });

    dialogRef.afterClosed().subscribe(result => {
      console.log('The dialog was closed');
    });
  }

}
