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

@NgModule({
  declarations: [
    FlmsComponent,
    CreateClubComponent,
    ViewProfileComponent,
    RequestListComponent
  ],
  imports: [
    CommonModule,
    RouterModule,
    MatInputModule,
    MatGridListModule,
    MatFormFieldModule,
    MatIconModule,
    MatToolbarModule,
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
    ReactiveFormsModule
  ]
})
export class FlmsModule { }
