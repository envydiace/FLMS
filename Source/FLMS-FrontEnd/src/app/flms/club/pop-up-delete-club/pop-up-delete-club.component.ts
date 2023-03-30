import { Component, OnInit, Inject } from '@angular/core';
import { CommonService } from '../../../common/common/common.service';
import { MatDialogRef, MAT_DIALOG_DATA, MatDialog } from '@angular/material/dialog';
import { first } from 'rxjs/operators';
import { ClubService } from '../club.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-pop-up-delete-club',
  templateUrl: './pop-up-delete-club.component.html',
  styleUrls: ['./pop-up-delete-club.component.scss']
})
export class PopUpDeleteClubComponent implements OnInit {
  loading = false;
  constructor(
    private commonService: CommonService,
    private clubService: ClubService,
    public dialogRe: MatDialog,
    public dialogRef: MatDialogRef<PopUpDeleteClubComponent>,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      clubId: number;
    },
    private router: Router,
  ) { }

  ngOnInit(): void {
  }

  onNoClick(): void {
    this.dialogRef.close();
  }

  onSubmit() {
    // stop here if form is invalid
     this.loading = true;
     this.clubService.deleteClub(this.data.clubId)
       .pipe(first())
       .subscribe({
         next: () => {
           this.dialogRef.close();
           this.commonService.sendMessage('Delete club success!','success');
           this.router.navigate(['manager/my-clubs'])
         },
         error: error => {
           this.loading = false;
           this.commonService.sendMessage(error.error.message,'fail');
         }
       });
   }
}
