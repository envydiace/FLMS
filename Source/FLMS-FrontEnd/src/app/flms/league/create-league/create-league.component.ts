import { Component, Inject, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { PopUpUpdateFeeComponent } from '../pop-up-update-fee/pop-up-update-fee.component';
import { leaguePrize } from '../../../models/league-prize.model';
import { createLeagueInfo } from '../../../models/create-league-info.model';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { LeagueService } from 'src/app/guest-view/league/league.service';
import { CommonService } from 'src/app/common/common/common.service';
import { finalize, first } from 'rxjs/operators';
import { PopUpUpdatePrizeComponent } from '../pop-up-update-prize/pop-up-update-prize.component';
import { AngularFireStorage } from '@angular/fire/storage';
import { formatDate } from '@angular/common';

@Component({
  selector: 'app-create-league',
  templateUrl: './create-league.component.html',
  styleUrls: ['./create-league.component.scss']
})
export class CreateLeagueComponent implements OnInit {
  loading = false;
  createLeagueForm: FormGroup;
  leagueInfo: createLeagueInfo;
  feeCostTotal: number = 0;
  prizeCostTotal: number = 0;
  selectedImage: any = null;
  imgSrc: string = './../../../../assets/image/default-logo.png';

  listPrize: leaguePrize[] = [
    { expenseKey: 'F1', expenseName: 'Gold Medal', cost: 0 },
    { expenseKey: 'F2', expenseName: 'Silver Medal', cost: 0 },
    { expenseKey: 'F3', expenseName: 'Bronze Medal', cost: 0 },
    { expenseKey: 'F4', expenseName: 'Best Player', cost: 0 },
    { expenseKey: 'F5', expenseName: 'Top Score', cost: 0 },
    { expenseKey: 'F6', expenseName: 'Top assist', cost: 0 },
    { expenseKey: 'F7', expenseName: 'Best GK', cost: 0 }
  ];

  listFee: leaguePrize[] = [];

  constructor(
    private formBuilder: FormBuilder,
    private leagueService: LeagueService,
    private commonService: CommonService,
    public dialog: MatDialog,
    @Inject(AngularFireStorage) private storage: AngularFireStorage
  ) {
  }

  ngOnInit(): void {
    this.createForm();
  }

  openDialogUpdateFee(): void {
    const dialogRef = this.dialog.open(PopUpUpdateFeeComponent, {
      width: '1000px',
      data: { listFee: this.listFee },
      disableClose: true
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result != null || result != undefined) this.listFee = result;
      this.getTotal();
      console.log('The dialog was closed');
    });
  }

  openDialogUpdatePrize(): void {
    const dialogRef = this.dialog.open(PopUpUpdatePrizeComponent, {
      width: '1000px',
      data: { leaguePrize: this.listPrize },
      disableClose: true
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result != null || result != undefined) this.listPrize = result;
      this.getTotal();
      console.log('The dialog was closed');
    });
  }

  createForm() {
    this.createLeagueForm = this.formBuilder.group({
      'leagueName': [null, [Validators.required]],
      'noParticipate': [null, [Validators.required, Validators.min(2), Validators.max(20)]],
      'startDate': [null, [Validators.required]],
      'endDate': [null, [Validators.required]],
      'maxNoPlayer': [null, [Validators.required, Validators.min(7), Validators.max(30)]],
      'noPlayerSquad': [null, [Validators.required, Validators.min(5), Validators.max(11)]],
      'location': [null, [Validators.required]],
      'fanpage': [null, [Validators.required]],
      'leagueType': [null, [Validators.required]],
      'noRound': [null],
      'description': [null, [Validators.required]],
      'logo': [null],
      'sponsored': [0, [Validators.required]]
    });
  }

  getControl(name: string) {
    return this.createLeagueForm.get(name) as FormControl;
  }

  bindDataIntoLeague() {
    this.leagueInfo = {
      leagueName: this.getControl('leagueName').value,
      noParticipate: this.getControl('noParticipate').value,
      startDate: this.commonService.addHoursToDate(this.getControl('startDate').value),
      endDate: this.commonService.addHoursToDate(this.getControl('endDate').value),
      maxNoPlayer: this.getControl('maxNoPlayer').value,
      noPlayerSquad: this.getControl('noPlayerSquad').value,
      location: this.getControl('location').value,
      fanpage: this.getControl('fanpage').value,
      leagueType: this.getControl('leagueType').value,
      noRound: this.getControl('noRound').value,
      description: this.getControl('description').value,
      logo: this.getControl('logo').value,
      sponsored: this.getControl('sponsored').value,
      prizes: this.listPrize,
      fees: this.listFee
    }
  }

  onSubmit() {
    this.bindDataIntoLeague();

    // stop here if form is invalid
    if (this.createLeagueForm.invalid) {
      return;
    }

    this.loading = true;

    // upload image to firebase
    const nameImg = 'league/' + this.leagueInfo.leagueName + '/logo/' + this.getCurrentDateTime() + this.selectedImage.name;
    const fileRef = this.storage.ref(nameImg);

    if (this.selectedImage != null) {
      this.storage.upload(nameImg, this.selectedImage).snapshotChanges().pipe(
        finalize(() => {
          fileRef.getDownloadURL().subscribe((url) => {

            this.leagueInfo.logo = url;

            this.leagueService.createLeague(this.leagueInfo)
              .pipe(first())
              .subscribe({
                next: () => {
                  this.loading = false;
                  this.commonService.sendMessage('Create League Success!', 'success');
                },
                error: error => {
                  this.loading = false;
                  this.commonService.sendMessage(error.error.message, 'fail');
                }
              });
          });
        })
      ).subscribe();
    } else {
      this.leagueService.createLeague(this.leagueInfo)
        .pipe(first())
        .subscribe({
          next: () => {
            this.loading = false;
            this.commonService.sendMessage('Create League Success!', 'success');
          },
          error: error => {
            this.loading = false;
            this.commonService.sendMessage(error.error.message, 'fail');
          }
        });
    }
  }

  getCurrentDateTime(): string {
    return formatDate(new Date(), 'dd-MM-yyyy', 'en-US');
  }

  getTotal() {
    if (this.listFee != null) {
      this.feeCostTotal = 0;
      this.listFee.forEach(element => {
        this.feeCostTotal += element.cost;
      });
    }

    this.prizeCostTotal = 0;
    this.listPrize.forEach(element => {
      this.prizeCostTotal += element.cost;
    });
  }

  showPreview(event: any) {
    // this.selectedImage = event.target.files[0];
    if (event.target.files && event.target.files[0]) {
      let file = event.target.files[0];
      if (file.type == "image/png" || file.type == "image/jpeg" || file.size < 5000000) {
        console.log('Correct');
        const reader = new FileReader();
        reader.onload = (e: any) => this.imgSrc = e.target.result;
        reader.readAsDataURL(event.target.files[0]);
        this.selectedImage = event.target.files[0];
      } else {
        this.commonService.sendMessage('Invalid Image', 'fail');
      }
    } else {
      this.imgSrc = './../../../.  ./assets/image/default-logo.png';
      this.selectedImage = null;
    }
  }


}
