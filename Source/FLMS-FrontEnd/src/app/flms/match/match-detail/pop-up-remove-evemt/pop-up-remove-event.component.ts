import { CommonService } from 'src/app/common/common/common.service';
import { MatchService } from '../../match.service';
import { MatDialog, MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog'
import { ChangeDetectorRef, Component, Inject, OnInit } from '@angular/core';
import { first } from 'rxjs/operators';

@Component({
  selector: 'app-pop-up-remove-evemt',
  templateUrl: './pop-up-remove-evemt.component.html',
  styleUrls: ['./pop-up-remove-evemt.component.scss']
})
export class PopUpRemoveEvemtComponent implements OnInit {

  loading = false;


  constructor(
    public matchService: MatchService,
    public commonService: CommonService,
    public dialog: MatDialog,
    public dialogRef: MatDialogRef<PopUpRemoveEvemtComponent>,

    @Inject(MAT_DIALOG_DATA)
    public data: {
      eventId: number
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
     this.matchService.removeEvent(this.data.eventId)
       .subscribe({
         next: response => {
           this.dialogRef.close();
           this.commonService.sendMessage(response.message,'success')
           
         },
         error: error => {
           this.loading = false;
           this.commonService.sendMessage(error.error.message,'fail')
         }
       });
   }
 
}
