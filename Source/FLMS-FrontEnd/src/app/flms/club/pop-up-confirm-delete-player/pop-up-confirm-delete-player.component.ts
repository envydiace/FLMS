import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA, MatDialog } from '@angular/material/dialog';
import { first } from 'rxjs/operators';
import { CommonService } from 'src/app/common/common/common.service';
import { ClubService } from '../club.service';

@Component({
  selector: 'app-pop-up-confirm-delete-player',
  templateUrl: './pop-up-confirm-delete-player.component.html',
  styleUrls: ['./pop-up-confirm-delete-player.component.scss']
})
export class PopUpConfirmDeletePlayerComponent implements OnInit {
  loading = false;

  constructor(
    private commonService: CommonService,
    private clubService: ClubService,
    public dialogRe: MatDialog,
    public dialogRef: MatDialogRef<PopUpConfirmDeletePlayerComponent>,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      playerId: number;
    }
  ) {

   }

  ngOnInit(): void {
  }

  onNoClick(): void {
    this.dialogRef.close();
  }

  onSubmit() {
    // stop here if form is invalid
 
     this.loading = true;
     this.clubService.removePlayer(this.data.playerId)
       .pipe(first())
       .subscribe({
         next: () => {
           this.dialogRef.close();
           this.commonService.sendMessage('player is deleted!','success')
         },
         error: error => {
           this.loading = false;
           this.commonService.sendMessage(error.error.message,'fail')
         }
       });
   }
}
