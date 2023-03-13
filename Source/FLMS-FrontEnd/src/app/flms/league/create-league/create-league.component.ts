import { Component, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { PopUpUpdateFeeComponent } from '../pop-up-update-fee/pop-up-update-fee.component';
import { leaguePrize } from '../../../models/league-prize.model';
import { createLeagueInfo } from '../../../models/create-league-info.model';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { LeagueService } from 'src/app/guest-view/league/league.service';
import { first } from 'rxjs/operators';

@Component({
  selector: 'app-create-league',
  templateUrl: './create-league.component.html',
  styleUrls: ['./create-league.component.scss']
})
export class CreateLeagueComponent implements OnInit {
  loading = false;
  createLeagueForm: FormGroup;
  leagueInfo: createLeagueInfo;

  listPrize: leaguePrize[] = [
    { expenseKey: 'F0', expenseName: 'Sponsored', cost: 0 },
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
    public dialog: MatDialog
  ) {
  }

  ngOnInit(): void {
    this.createForm();
  }

  openDialogUpdateFee(): void {
    const dialogRef = this.dialog.open(PopUpUpdateFeeComponent, {
      width: '1000px',
      data: { leaguePrize: this.listPrize },
      disableClose: true
    });

    dialogRef.afterClosed().subscribe(result => {
      this.listPrize = result;
      console.log('The dialog was closed');
    });
  }

  createForm() {
    this.createLeagueForm = this.formBuilder.group({
      'leagueName': [null, [Validators.required]],
      'noParticipate': [null, [Validators.required]],
      'playerHeight': [null, [Validators.required]],
      'startDate': [null, [Validators.required]],
      'endDate': [null, [Validators.required]],
      'maxNoPlayer': [null, [Validators.required]],
      'noPlayerSquad': [null, [Validators.required]],
      'location': [null, [Validators.required]],
      'fanpage': [null, [Validators.required]],
      'leagueType': [null, [Validators.required]],
      'noRound': [null, [Validators.required]],
      'description': [null, [Validators.required]],
      'logo': [null, [Validators.required]],
      'sponsored': [null, [Validators.required]]
    });
  }

  getControl(name: string) {
    return this.createLeagueForm.get(name) as FormControl;
  }

  bindDataIntoLeague() {
    this.leagueInfo = {
      leagueName: this.getControl('leagueName').value,
      noParticipate: this.getControl('noParticipate').value,
      startDate: this.getControl('startDate').value,
      endDate: this.getControl('endDate').value,
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
    this.leagueService.createLeague(this.leagueInfo)
      .pipe(first())
      .subscribe({
        next: () => {

        },
        error: error => {
          this.loading = false;
        }
      });
  }
}
