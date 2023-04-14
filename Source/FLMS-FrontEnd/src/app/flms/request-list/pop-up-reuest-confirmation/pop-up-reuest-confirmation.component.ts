import { Component, OnInit, Inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { Router } from '@angular/router';
import { CommonService } from 'src/app/common/common/common.service';
import { RequestService } from '../request.service';
import { first } from 'rxjs/operators';
import { token } from 'src/app/models/token.model';

@Component({
  selector: 'app-pop-up-reuest-confirmation',
  templateUrl: './pop-up-reuest-confirmation.component.html',
  styleUrls: ['./pop-up-reuest-confirmation.component.scss']
})
export class PopUpReuestConfirmationComponent implements OnInit {
  loading = false;
  stringType: string = '';
  token: token;
  userRole: string = null;

  constructor(
    private commonService: CommonService,
    private requestService: RequestService,

    public dialogRef: MatDialogRef<PopUpReuestConfirmationComponent>,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      requestId: number,
      action: string
    },
    private router: Router,
  ) {
    this.token = JSON.parse(localStorage.getItem('user'));
  }

  ngOnInit(): void {
    this.stringType = this.data.action;
    this.userRole = this.token.role;
  }

  onNoClick(): void {
    this.dialogRef.close();
  }
  onSubmit() {
    // stop here if form is invalid
    this.loading = true;
    this.requestService.updateRequestStatus(this.data.requestId, this.data.action)
      .pipe(first())
      .subscribe({
        next: response => {
          this.dialogRef.close();
          if (this.userRole == 'LEAGUE_MANAGER') {
            if (this.data.action = 'AcceptRegistration') {
              this.commonService.sendMessage('Accept sucess', 'success');
            }
            else if (this.data.action = 'RejectRegistration') {
              this.commonService.sendMessage('Reject sucess', 'success');
            }
            else if (this.data.action = 'CancelInvitation') {
              this.commonService.sendMessage('Cancel sucess', 'success');
            }

          } 
          else if ( this.userRole == 'CLUB_MANAGER'){
            if (this.data.action = 'AcceptInvitation') {
              this.commonService.sendMessage('Accept sucess', 'success');
            }
            else if (this.data.action = 'RejectInvitation') {
              this.commonService.sendMessage('Reject sucess', 'success');
            }
            else if (this.data.action = 'CancelRegistration') {
              this.commonService.sendMessage('Cancel sucess', 'success');
            }
          }



        },
        error: error => {
          this.loading = false;
          this.commonService.sendMessage(error.error.message, 'fail');
        }
      });
  }


}
