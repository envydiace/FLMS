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
import { MatSnackBarModule } from '@angular/material/snack-bar';	
import { MatChipsModule } from '@angular/material/chips';	
import { MatSelectModule } from '@angular/material/select';
import { MatDialogModule } from '@angular/material/dialog';
import { MatDatepickerModule } from '@angular/material/datepicker';	
import { MatNativeDateModule } from '@angular/material/core';	
import { MatTabsModule } from '@angular/material/tabs';
import { MatListModule } from '@angular/material/list';
import { CdkTableModule } from '@angular/cdk/table';
import { ClubDetailComponent } from './club/club-detail/club-detail.component';
import { ClubListComponent } from './club/club-list/club-list.component';
import { ClubScheduleComponent } from './club/club-detail/club-schedule/club-schedule.component';
import { ClubPlayerComponent } from './club/club-detail/club-player/club-player.component';
import { PopUpAddPlayerComponent } from './club/club-detail/pop-up-add-player/pop-up-add-player.component';

@NgModule({
  declarations: [
    FlmsComponent,
    CreateClubComponent,
    ViewProfileComponent,
    RequestListComponent,
    ClubDetailComponent,
    ClubListComponent,
    ClubScheduleComponent,
    ClubPlayerComponent,
    PopUpAddPlayerComponent
  ],
  imports: [
    CommonModule,
    RouterModule,
    MatInputModule,
    MatGridListModule,
    MatFormFieldModule,
    MatIconModule,
    MatToolbarModule,
    MatSortModule,
    MatTableModule,
    MatPaginatorModule,
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
    MatSelectModule
  ]
})
export class FlmsModule { }
