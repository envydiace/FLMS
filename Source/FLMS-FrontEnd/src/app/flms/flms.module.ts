import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FlmsRoutingModule } from './flms-routing.module';
import { FlmsComponent } from './flms.component';
import { MatInputModule } from '@angular/material/input';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatGridListModule } from '@angular/material/grid-list';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatDividerModule } from '@angular/material/divider';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatSidenavModule } from '@angular/material/sidenav';
import { CreateClubComponent } from './club/create-club/create-club.component';
import { RouterModule } from '@angular/router';
import { ViewProfileComponent } from './profile/view-profile/view-profile.component';
import { MatIconModule } from '@angular/material/icon';
import { RequestListComponent } from './request-list/request-list.component';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatTableModule } from '@angular/material/table';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatSortModule } from '@angular/material/sort';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { CreateLeagueComponent } from './league/create-league/create-league.component';
import { LeagueListComponent } from './league/league-list/league-list.component';
import { LeagueDetailComponent } from './league/league-detail/league-detail.component';
import { PopUpUpdateFeeComponent } from './league/pop-up-update-fee/pop-up-update-fee.component';
import { MatSnackBarModule } from '@angular/material/snack-bar';
import { MatChipsModule } from '@angular/material/chips';
import { MatDialogModule } from '@angular/material/dialog';
import { MatMenuModule } from '@angular/material/menu';
import { MatNativeDateModule } from '@angular/material/core';
import { MatTabsModule } from '@angular/material/tabs';
import { MatListModule } from '@angular/material/list';
import { CdkTableModule } from '@angular/cdk/table';
import { ClubDetailComponent } from './club/club-detail/club-detail.component';
import { ClubListComponent } from './club/club-list/club-list.component';
import { ClubScheduleComponent } from './club/club-detail/club-schedule/club-schedule.component';
import { ClubPlayerComponent } from './club/club-detail/club-player/club-player.component';
import { PopUpAddPlayerComponent } from './club/club-detail/pop-up-add-player/pop-up-add-player.component';
import { PopUpUpdatePrizeComponent } from './league/pop-up-update-prize/pop-up-update-prize.component';
import { LeagueScheduleComponent } from './league/league-detail/league-schedule/league-schedule.component';
import { JoinedClubsComponent } from './league/league-detail/joined-clubs/joined-clubs.component'
import { LeagueStatisticComponent } from './league/league-detail/league-statistic/league-statistic.component'
import { LeagueFeeComponent } from './league/league-detail/league-fee/league-fee.component'
import { LeagueSettingsComponent } from './league/league-detail/league-settings/league-settings.component'
import { ConfirmFeeComponent } from './league/league-detail/confirm-fee/confirm-fee.component'
import { MatSelectModule } from '@angular/material/select';


import { PopUpLeagueFeeDetailComponent } from './league/league-detail/pop-up-league-fee-detail/pop-up-league-fee-detail.component'

@NgModule({
  declarations: [
    FlmsComponent,
    CreateClubComponent,
    ViewProfileComponent,
    RequestListComponent,
    CreateLeagueComponent,
    LeagueListComponent,
    LeagueDetailComponent,
    PopUpUpdateFeeComponent,
    JoinedClubsComponent,
    LeagueStatisticComponent,
    ConfirmFeeComponent,
    LeagueFeeComponent,
    LeagueSettingsComponent,
    LeagueScheduleComponent,
    ClubDetailComponent,
    ClubListComponent,
    ClubScheduleComponent,
    ClubPlayerComponent,
    PopUpAddPlayerComponent,
    PopUpLeagueFeeDetailComponent,

    PopUpUpdatePrizeComponent,
  ],
  imports: [
    CommonModule,
    RouterModule,
    MatInputModule,
    MatGridListModule,
    MatFormFieldModule,
    MatIconModule,
    MatToolbarModule,
    MatMenuModule,
    MatSortModule,
    MatTableModule,
    MatSelectModule,
    MatPaginatorModule,
    MatDialogModule,
    MatSidenavModule,
    MatExpansionModule,
    MatDividerModule,
    MatButtonModule,
    MatIconModule,
    MatCardModule,
    FormsModule,
    FlmsRoutingModule,
    ReactiveFormsModule,
    MatSnackBarModule,
    MatChipsModule,
    MatDialogModule,
    MatDatepickerModule,
    MatNativeDateModule,
    MatTabsModule,
    MatListModule,
    CdkTableModule
  ]
})
export class FlmsModule { }
