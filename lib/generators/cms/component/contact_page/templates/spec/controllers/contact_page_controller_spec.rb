require 'spec_helper'

describe ContactPageController do
  let(:homepage) { mock_model(Homepage, permalink: 'homepage') }
  let(:contact_page) { mock(ContactPage, locale: 'en', activity_type: 'contact-test', redirect_after_submit: homepage) }

  before do
    request.for_cms_object(contact_page)

    controller.stub(:ensure_object_is_active).and_return(true)
    controller.stub(:ensure_object_is_permitted).and_return(true)
    controller.stub(:set_google_expire_header).and_return(true)
  end

  describe 'get index' do
    it 'renders index template' do
      get :index

      response.should render_template(:index)
    end

    it 'assigns @contact_page_presenter' do
      get :index

      assigns[:contact_page_presenter].should be_a(ContactPagePresenter)
    end
  end

  describe 'post index' do
    it 'assigns @contact_page_presenter' do
      post :index

      assigns[:contact_page_presenter].should be_a(ContactPagePresenter)
    end

    context 'invalid data' do
      it 'renders index template' do
        post :index

        response.should render_template(:index)
      end
    end

    context 'valid data' do
      let(:service) { mock_model('Service', submit: true) }
      let(:attributes) { { 'email' => 'test@test.de', 'subject' => 'test', 'message' => 'test' } }

      before do
        ContactActivityService.should_receive(:new).with(attributes, contact_page.activity_type, anything).and_return(service)
      end

      it 'redirects to hompage' do
        post :index, { contact_page_presenter: attributes }

        response.should redirect_to("http://test.host/#{homepage.permalink}")
      end

      it 'sets flash notice' do
        post :index, { contact_page_presenter: attributes }

        flash[:notice].should be_present
      end
    end
  end
end