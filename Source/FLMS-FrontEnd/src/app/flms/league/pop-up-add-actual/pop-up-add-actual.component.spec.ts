import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PopUpAddActualComponent } from './pop-up-add-actual.component';

describe('PopUpAddActualComponent', () => {
  let component: PopUpAddActualComponent;
  let fixture: ComponentFixture<PopUpAddActualComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PopUpAddActualComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PopUpAddActualComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
