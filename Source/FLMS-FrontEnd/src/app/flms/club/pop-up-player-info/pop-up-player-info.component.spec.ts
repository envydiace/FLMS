import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PopUpPlayerInfoComponent } from './pop-up-player-info.component';

describe('PopUpPlayerInfoComponent', () => {
  let component: PopUpPlayerInfoComponent;
  let fixture: ComponentFixture<PopUpPlayerInfoComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PopUpPlayerInfoComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PopUpPlayerInfoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
