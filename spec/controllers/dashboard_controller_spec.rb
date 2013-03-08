require 'spec_helper'
require 'pry'

module InfoparkKickstarter
  describe DashboardsController do
    let(:editors) { [mock('Editor')] }
    let(:developers) { [mock('Developer')] }
    let(:gems) { [mock('Gem')] }
    let(:cms_stats) { [mock('CmsStats')] }
    let(:crm_stats) { [mock('CrmStats')] }

    before do
      Dashboard::Editor.stub(:all).and_return(editors)
      Dashboard::Developer.stub(:all).and_return(developers)
      Dashboard::Gem.stub(:all).and_return(gems)
      Dashboard::CmsStats.stub(:new).and_return(cms_stats)
      Dashboard::CrmStats.stub(:new).and_return(crm_stats)
    end

    it 'does not allow remote requests' do
      controller.stub(:local_request? => false)

      get :show, use_route: 'cms'

      response.status.should eq(403)
    end

    it 'renders an error message when request was forbidden' do
      controller.stub(:local_request? => false)

      get :show, use_route: 'cms'

      response.body.should include('p')
    end

    it 'allows local requests' do
      get :show, use_route: 'cms'

      response.should be_success
    end

    shared_examples 'it renders the dashboard layout' do
      it 'renders dashboard layout' do
        get action, use_route: 'cms'

        response.should render_template('infopark_kickstarter/dashboard')
      end
    end

    describe '#show' do
      let(:action) { :show }
      it_behaves_like 'it renders the dashboard layout'

      it 'assigns stats' do
        get action, use_route: 'cms'

        assigns[:meta_stats].should be_a(Dashboard::MetaStats)
      end
    end

    describe '#help' do
      let(:action) { :help }
      it_behaves_like 'it renders the dashboard layout'

      it 'assigns gems' do
        get action, use_route: 'cms'

        assigns[:gems].should eq(gems)
      end
    end

    describe '#people' do
      let(:action) { :people }
      it_behaves_like 'it renders the dashboard layout'

      it 'assigns editors and developers' do
        get action, use_route: 'cms'

        assigns[:editors].should eq(editors)
        assigns[:developers].should eq(developers)
      end
    end

    describe '#content' do
      let(:action) { :content }
      it_behaves_like 'it renders the dashboard layout'

      it 'assigns cms and crm stats' do
        get action, use_route: 'cms'

        assigns[:cms_stats].should eq(cms_stats)
        assigns[:crm_stats].should eq(crm_stats)
      end
    end
  end
end