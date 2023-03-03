import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CreateClubComponent } from './club/create-club/create-club.component';
import { ViewProfileComponent } from './profile/view-profile/view-profile.component';

const routes: Routes = [
  {
    path: 'create-club',
    component: CreateClubComponent
  },
  {
    path: 'view-profile',
    component: ViewProfileComponent
  }
];


@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class FlmsRoutingModule { }
