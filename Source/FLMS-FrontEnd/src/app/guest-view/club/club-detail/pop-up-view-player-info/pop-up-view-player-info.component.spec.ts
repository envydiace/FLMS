import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PopUpViewPlayerInfoComponent } from './pop-up-view-player-info.component';

describe('PopUpViewPlayerInfoComponent', () => {
  let component: PopUpViewPlayerInfoComponent;
  let fixture: ComponentFixture<PopUpViewPlayerInfoComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PopUpViewPlayerInfoComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PopUpViewPlayerInfoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
