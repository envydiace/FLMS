import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { CreateClubComponent } from './club/create-club/create-club.component';

const routes: Routes = [
  {
    path: 'create-club',
    component: CreateClubComponent
  }
];

const routes: Routes = [
  {
    path: 'profile',
    component: ViewProfileComponent
  },



];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class FlmsRoutingModule { }
