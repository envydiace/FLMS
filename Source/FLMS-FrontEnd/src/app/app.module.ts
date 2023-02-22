import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { MainComponent } from './layouts/main/main.component';
import { NavbarComponent } from './layouts/navbar/navbar.component';
import { FooterComponent } from './layouts/footer/footer.component';
import { VerticalMenuComponent } from './layouts/vertical-menu/vertical-menu.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { MatSidenavModule } from "@angular/material/sidenav";
import { MatListModule } from "@angular/material/list";
import { MatButtonModule } from "@angular/material/button";
import { MatIconModule } from "@angular/material/icon";
import { MatExpansionModule } from '@angular/material/expansion';
import { FlmsModule } from './flms/flms.module';
import { HomepageComponent } from './guest-view/homepage/homepage.component';
import { LoginComponent } from './guest-view/login/login.component';
import { GuestViewModule } from './guest-view/guest-view.module';
import { HttpClientModule } from '@angular/common/http';

import {MatDatepickerModule} from '@angular/material/datepicker';


import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {MatNativeDateModule} from '@angular/material/core';


@NgModule({
  declarations: [
    MainComponent,
    NavbarComponent,
    FooterComponent, 
    VerticalMenuComponent
  ],
  imports: [
    BrowserModule,
    BrowserAnimationsModule,
    MatSidenavModule,
    MatListModule,
    MatIconModule,
    MatButtonModule,
    MatExpansionModule,
    FlmsModule,
    AppRoutingModule,
    HttpClientModule,
    MatDatepickerModule
  ],
  providers: [],
  bootstrap: [MainComponent]
})
export class AppModule { }
