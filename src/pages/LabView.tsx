import React from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import LabContent from '@/components/LabContent';
import { helloWorldLab } from '@/data/labs/hello-world';
import { Lab } from '@/types/lab';

const LabView: React.FC = () => {
  const { labId } = useParams<{ labId: string }>();
  const navigate = useNavigate();

  // For now, we'll have a simple mapping. This will be expanded as we migrate more labs
  const labs: Record<string, Lab> = {
    'hello-world': helloWorldLab,
  };

  const lab = labId ? labs[labId] : null;

  if (!lab) {
    return (
      <div className="min-h-screen bg-gray-50 dark:bg-gray-900 flex items-center justify-center">
        <div className="text-center">
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white mb-4">
            Lab Not Found
          </h1>
          <p className="text-gray-600 dark:text-gray-400 mb-6">
            The lab you're looking for doesn't exist or hasn't been migrated yet.
          </p>
          <button
            onClick={() => navigate('/labs')}
            className="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg"
          >
            Back to Labs
          </button>
        </div>
      </div>
    );
  }

  const handlePrevious = () => {
    if (lab.previousLab) {
      navigate(`/labs/${lab.previousLab}`);
    }
  };

  const handleNext = () => {
    if (lab.nextLab) {
      navigate(`/labs/${lab.nextLab}`);
    }
  };

  const handleBack = () => {
    navigate('/labs');
  };

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
      <LabContent
        lab={lab}
        onPrevious={lab.previousLab ? handlePrevious : undefined}
        onNext={lab.nextLab ? handleNext : undefined}
        onBack={handleBack}
      />
    </div>
  );
};

export default LabView;
