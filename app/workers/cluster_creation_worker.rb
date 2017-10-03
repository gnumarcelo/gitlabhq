class ClusterCreationWorker
  include Sidekiq::Worker
  include ClusterQueue

  def perform(cluster_id)
    Gcp::Cluster.find_by_id(cluster_id).try do |cluster|
      Ci::CreateGkeClusterService.new.execute(cluster)
    end
  end
end
