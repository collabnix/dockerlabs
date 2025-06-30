import { Lab } from '@/types/lab';
import { helloWorldLab } from '@/labs/beginners/hello-world';
import { dockerImagesLab } from '@/labs/beginners/docker-images';
import { dockerfileBasicsLab } from '@/labs/beginners/dockerfile-basics';
import { dockerVolumesLab } from '@/labs/beginners/docker-volumes';
import { dockerComposeLab } from '@/labs/beginners/docker-compose';

export const labRegistry: Record<string, Lab> = {
  'docker-hello-world': helloWorldLab,
  'docker-images-basics': dockerImagesLab,
  'dockerfile-basics': dockerfileBasicsLab,
  'docker-volumes-basics': dockerVolumesLab,
  'docker-compose-basics': dockerComposeLab,
};

export const getLabById = (id: string): Lab | undefined => {
  return labRegistry[id];
};

export const getLabsByCategory = (category: string): Lab[] => {
  return Object.values(labRegistry).filter(lab => lab.category === category);
};

export const getAllLabs = (): Lab[] => {
  return Object.values(labRegistry);
};

export const getFeaturedLabs = (): Lab[] => {
  return Object.values(labRegistry).filter(lab => lab.featured);
};
