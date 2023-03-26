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
import { MatchEventComponent } from './match/match-detail/match-event/match-event.component';
import { MatchStatisticComponent } from './match/match-detail/match-statistic/match-statistic.component';
import { MatchDetailComponent } from './match/match-detail/match-detail.component';
import { MatSelectModule } from '@angular/material/select';
import { PopUpEditMatchStatsComponent } from './match/pop-up-edit-match-stats/pop-up-edit-match-stats.component'
import { PopUpLeagueFeeDetailComponent } from './league/league-detail/pop-up-league-fee-detail/pop-up-league-fee-detail.component';
import { JoinedLeagueComponent } from './club/joined-league/joined-league.component';
import { ViewSquadComponent } from './match/match-detail/view-squad/view-squad.component';
import { EditLineUpComponent } from './match/edit-line-up/edit-line-up.component';
import { DragDropModule } from '@angular/cdk/drag-drop';
import { ConfirmIsFinishComponent } from './league/pop-up-confirm-is-finish/pop-up-confirm-is-finish.component';
import { PopUpEditMatchInfoComponent } from './match/match-detail/pop-up-edit-match-info/pop-up-edit-match-info.component';
import { ClubIncomingMatchComponent } from './club/club-detail/club-incoming-match/club-incoming-match.component';
import { PopUpAddEventComponent } from './match/match-detail/pop-up-add-event/pop-up-add-event.component';
import { PopUpRemoveEvemtComponent } from './match/match-detail/pop-up-remove-evemt/pop-up-remove-event.component';
import { LeagueHistoryComponent } from './club/club-detail/league-history/league-history.component';
import { PlayerInfoComponent } from './club/player-info/player-info.component';
import { PopUpDeleteClubComponent } from './club/pop-up-delete-club/pop-up-delete-club.component';
import { PopUpConfirmDeletePlayerComponent } from './club/pop-up-confirm-delete-player/pop-up-confirm-delete-player.component';
import { PopupDeleteLeagueComponent } from './league/popup-delete-league/popup-delete-league.component';

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
    PopUpEditMatchStatsComponent,
    PopUpAddEventComponent,
    PopUpUpdatePrizeComponent,
    MatchEventComponent,
    MatchDetailComponent,
    MatchStatisticComponent,
    JoinedLeagueComponent,
    ViewSquadComponent,
    EditLineUpComponent,
    PopUpEditMatchInfoComponent,
    LeagueHistoryComponent,
    ConfirmIsFinishComponent,
    ClubIncomingMatchComponent,
    PopUpRemoveEvemtComponent,
    PopUpDeleteClubComponent,
    PopupDeleteLeagueComponent,
    PlayerInfoComponent,
    PopUpDeleteClubComponent,
    PopUpConfirmDeletePlayerComponent
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
    CdkTableModule,
    DragDropModule
  ]
})
export class FlmsModule { }
