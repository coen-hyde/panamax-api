require 'spec_helper'

describe TemplateBuilder::FromApp do

  let(:options) do
    {
      description: 'some template',
      keywords: 'foo,baz,bar',
      type: 'wordpress',
      documentation: '---\n\nBlah\n\n'
    }
  end
  subject { described_class.new apps(:app1), options }

  context '.create_template' do

    it 'converts an app to a template given the app_id' do
      expect(subject.create_template).to be_a Template
    end

    describe 'assigns the options provided to the template' do
      subject { described_class.new(apps(:app1), options).create_template }
      its(:name) { should eq apps(:app1).name }
      its(:description) { should eq options[:description] }
      its(:keywords) { should eq options[:keywords] }
      its(:type) { should eq options[:type] }
      its(:documentation) { should eq options[:documentation] }
    end

    it 'persists the template if valid' do
      expect(subject.create_template).to be_persisted
    end

    it 'returns a template with errors if the template cannot be persisted' do
      options[:name] = nil
      t = described_class.new(apps(:app1), options).create_template
      expect(t).to_not be_persisted
      expect(t.errors).to_not be_empty
    end

    context 'when persisted flag is false' do
      it 'returns an unpersisted template ' do
        t = subject.create_template(false)
        expect(t.persisted?).to be_false
      end
    end

  end
end
